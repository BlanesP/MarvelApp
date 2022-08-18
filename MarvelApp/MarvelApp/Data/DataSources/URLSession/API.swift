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
        let description: String?
        let thumbnail: Image?
    }

    struct Image: Decodable {
        let path: String?
        let `extension`: String?
    }
}
