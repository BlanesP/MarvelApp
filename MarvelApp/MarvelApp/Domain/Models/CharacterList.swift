//
//  CharacterList.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation

struct CharacterList {
    let total: Int
    let attributionText: String
    let characters: [Character]
}

extension CharacterList {
    struct Character: Identifiable {
        let id: Int
        let name: String
        let icon: URL
        let comics: [String]
        let stories: [String]
        let events: [String]
        let series: [String]
    }
}
