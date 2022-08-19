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
        let iconUrl: URL
        let comics: [CharacterItem]
        let stories: [CharacterItem]
        let events: [CharacterItem]
        let series: [CharacterItem]
    }
}
