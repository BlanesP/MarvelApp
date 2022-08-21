//
//  CharactersRepositoryImpl.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import Foundation

final class CharactersRepositoryImpl: MarvelAuthorized, Logger {
    let dataSource: URLSessionDataSource

    init(dataSource: URLSessionDataSource) {
        self.dataSource = dataSource
    }
}

extension CharactersRepositoryImpl: CharactersRepository {
    
    func fetchCharacters(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error> {
        log("Fetching characters...")

        guard let authorization = authorization else {
            return Fail(error: BasicError(message: "Could not authorize")).eraseToAnyPublisher()
        }

        return dataSource
            .fetchCharacters(
                input: CharactersRequest.Input(
                    ts: authorization.ts,
                    apikey: authorization.apikey,
                    hash: authorization.hash,
                    limit: pageSize,
                    offset: page * pageSize
                )
            )
            .tryMap { try CharacterList(from: $0) }
            .eraseToAnyPublisher()
    }

    func fetchComic(id: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Fetching comic...")

        guard let authorization = authorization else {
            return Fail(error: BasicError(message: "Could not authorize")).eraseToAnyPublisher()
        }

        return dataSource
            .fetchComic(
                input: ComicRequest.Input(
                    ts: authorization.ts,
                    apikey: authorization.apikey,
                    hash: authorization.hash
                ),
                id: "\(id)"
            )
            .tryMap {
                guard let comic = $0.data?.results?.first else {
                    throw BasicError(message: "No comic")
                }

                return try CharacterItem(from: comic)
            }
            .eraseToAnyPublisher()
    }

    func fetchEvent(id: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Fetching event...")

        guard let authorization = authorization else {
            return Fail(error: BasicError(message: "Could not authorize")).eraseToAnyPublisher()
        }

        return dataSource
            .fetchEvent(
                input: EventRequest.Input(
                    ts: authorization.ts,
                    apikey: authorization.apikey,
                    hash: authorization.hash
                ),
                id: "\(id)"
            )
            .tryMap {
                guard let event = $0.data?.results?.first else {
                    throw BasicError(message: "No event")
                }

                return try CharacterItem(from: event)
            }
            .eraseToAnyPublisher()
    }

    func fetchSerie(id: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Fetching serie...")

        guard let authorization = authorization else {
            return Fail(error: BasicError(message: "Could not authorize")).eraseToAnyPublisher()
        }

        return dataSource
            .fetchSerie(
                input: SerieRequest.Input(
                    ts: authorization.ts,
                    apikey: authorization.apikey,
                    hash: authorization.hash
                ),
                id: "\(id)"
            )
            .tryMap {
                guard let serie = $0.data?.results?.first else {
                    throw BasicError(message: "No serie")
                }

                return try CharacterItem(from: serie)
            }
            .eraseToAnyPublisher()
    }
}

//MARK: - Mappers

extension CharacterList {
    init(from request: CharactersRequest.Response) throws {
        guard let data = request.data,
              let attributionText = request.attributionText,
              let total = data.total,
              let characters = data.results
        else {
            throw BasicError(message: "Could not parse CharacterRequest")
        }

        self.attributionText = attributionText
        self.total = total
        self.characters = characters.compactMap { Character(from: $0) }
    }
}

extension CharacterList.Character {
    init?(from request: CharactersRequest.Response.Character) {
        guard let id = request.id,
              let name = request.name,
              let iconPath = request.thumbnail?.path,
              let iconExtension = request.thumbnail?.extension,
              let iconUrl = URL(string: "\(iconPath.secureUrl).\(iconExtension)")
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.comics = request.comics?.items?.compactMap {
            CharacterItem(resourceUrl: $0.resourceURI, name: $0.name, type: .comic)
        } ?? []
        self.stories = request.stories?.items?.compactMap {
            CharacterItem(resourceUrl: $0.resourceURI, name: $0.name, type: .story)
        } ?? []
        self.events = request.events?.items?.compactMap {
            CharacterItem(resourceUrl: $0.resourceURI, name: $0.name, type: .event)
        } ?? []
        self.series = request.series?.items?.compactMap {
            CharacterItem(resourceUrl: $0.resourceURI, name: $0.name, type: .serie)
        } ?? []
    }
}

extension CharacterItem {
    init?(resourceUrl: String?, name: String?, type: CharacterItem.ItemType) {
        guard let name = name,
              let idString = resourceUrl?.components(separatedBy: "/").last,
              let id = Int(idString)
        else {
            return nil
        }

        self.id = id
        self.title = name
        self.type = type
    }

    init(from request: ComicRequest.Response.Comic) throws {
        guard let id = request.id,
              let title = request.title
        else {
            throw BasicError(message: "Could not parse ComicRequest")
        }

        self.id = id
        self.title = title
        self.type = .comic
        self.description = request.description

        if let path = request.thumbnail?.path?.secureUrl,
           let ext = request.thumbnail?.extension {
            self.imageUrl = URL(string: "\(path).\(ext)")
        }

        if let detailUrl = request.urls?.first(where: { $0.type == "detail" })?.url {
            self.detailUrl = URL(string: detailUrl)
        }
    }

    init(from request: EventRequest.Response.Event) throws {
        guard let id = request.id,
              let title = request.title
        else {
            throw BasicError(message: "Could not parse EventRequest")
        }

        self.id = id
        self.title = title
        self.type = .comic
        self.description = request.description

        if let path = request.thumbnail?.path?.secureUrl,
           let ext = request.thumbnail?.extension {
            self.imageUrl = URL(string: "\(path).\(ext)")
        }

        if let detailUrl = request.urls?.first(where: { $0.type == "detail" })?.url {
            self.detailUrl = URL(string: detailUrl)
        }
    }

    init(from request: SerieRequest.Response.Serie) throws {
        guard let id = request.id,
              let title = request.title
        else {
            throw BasicError(message: "Could not parse SerieRequest")
        }

        self.id = id
        self.title = title
        self.type = .comic
        self.description = request.description

        if let path = request.thumbnail?.path?.secureUrl,
           let ext = request.thumbnail?.extension {
            self.imageUrl = URL(string: "\(path).\(ext)")
        }

        if let detailUrl = request.urls?.first(where: { $0.type == "detail" })?.url {
            self.detailUrl = URL(string: detailUrl)
        }
    }
}
