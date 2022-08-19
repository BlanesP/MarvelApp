//
//  API.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation

//This should be generated from request data

//MARK: - Serie

struct SerieRequest {
    struct Input: Encodable {
        let ts: String
        let apikey: String
        let hash: String
    }

    struct Response: Decodable {
        let data: SerieDataContainer?
    }
}

extension SerieRequest.Response {
    struct SerieDataContainer: Decodable {
        let results: [Serie]?
    }

    struct Serie: Decodable {
        let id: Int?
        let title: String?
        let description: String?
        let thumbnail: Image?
        let urls: [URL]?
    }

    struct Image: Decodable {
        let path: String?
        let `extension`: String?
    }

    struct `URL`: Decodable {
        let type: String?
        let url: String?
    }
}

//MARK: - Event

struct EventRequest {
    struct Input: Encodable {
        let ts: String
        let apikey: String
        let hash: String
    }

    struct Response: Decodable {
        let data: EventDataContainer?
    }
}

extension EventRequest.Response {
    struct EventDataContainer: Decodable {
        let results: [Event]?
    }

    struct Event: Decodable {
        let id: Int?
        let title: String?
        let description: String?
        let thumbnail: Image?
        let urls: [URL]?
    }

    struct Image: Decodable {
        let path: String?
        let `extension`: String?
    }

    struct `URL`: Decodable {
        let type: String?
        let url: String?
    }
}

//MARK: - Comic

struct ComicRequest {
    struct Input: Encodable {
        let ts: String
        let apikey: String
        let hash: String
    }

    struct Response: Decodable {
        let data: ComicDataContainer?
    }
}

extension ComicRequest.Response {
    struct ComicDataContainer: Decodable {
        let results: [Comic]?
    }

    struct Comic: Decodable {
        let id: Int?
        let title: String?
        let description: String?
        let thumbnail: Image?
        let urls: [URL]?
    }

    struct Image: Decodable {
        let path: String?
        let `extension`: String?
    }

    struct `URL`: Decodable {
        let type: String?
        let url: String?
    }
}

//MARK: - Characters

struct CharactersRequest {
    struct Input: Encodable {
        let ts: String
        let apikey: String
        let hash: String
        let limit: Int
        let offset: Int
    }

    struct Response: Decodable {
        let attributionText: String?
        let data: CharacterDataContainer?
    }
}

extension CharactersRequest.Response {
    struct CharacterDataContainer: Decodable {
        let total: Int?
        let results: [Character]?
    }

    struct Character: Decodable {
        let id: Int?
        let name: String?
        let thumbnail: Image?
        let comics: ComicList?
        let stories: StoryList?
        let events: EventList?
        let series: SeriesList?
    }

    struct Image: Decodable {
        let path: String?
        let `extension`: String?
    }

    struct ComicList: Decodable {
        let items: [ComicSummary]?
    }

    struct ComicSummary: Decodable {
        let resourceURI: String?
        let name: String?
    }

    struct StoryList: Decodable {
        let items: [ComicSummary]?
    }

    struct StorySummary: Decodable {
        let resourceURI: String?
        let name: String?
    }

    struct EventList: Decodable {
        let items: [ComicSummary]?
    }

    struct EventSummary: Decodable {
        let resourceURI: String?
        let name: String?
    }

    struct SeriesList: Decodable {
        let items: [ComicSummary]?
    }

    struct SeriesSummary: Decodable {
        let resourceURI: String?
        let name: String?
    }
}
