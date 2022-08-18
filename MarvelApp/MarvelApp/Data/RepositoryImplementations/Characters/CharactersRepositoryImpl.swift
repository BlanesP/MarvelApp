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
              let iconUrl = URL(string: "\(iconPath.replacingOccurrences(of: "http:", with: "https:")).\(iconExtension)")
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.icon = iconUrl
        self.comics = request.comics?.items?.compactMap { $0.name } ?? []
        self.stories = request.stories?.items?.compactMap { $0.name } ?? []
        self.events = request.events?.items?.compactMap { $0.name } ?? []
        self.series = request.series?.items?.compactMap { $0.name } ?? []
    }
}
