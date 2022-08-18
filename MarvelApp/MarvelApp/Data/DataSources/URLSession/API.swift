//
//  API.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation

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
        let name: String?
    }

    struct StoryList: Decodable {
        let items: [ComicSummary]?
    }

    struct StorySummary: Decodable {
        let name: String?
    }

    struct EventList: Decodable {
        let items: [ComicSummary]?
    }

    struct EventSummary: Decodable {
        let name: String?
    }

    struct SeriesList: Decodable {
        let items: [ComicSummary]?
    }

    struct SeriesSummary: Decodable {
        let name: String?
    }
}
