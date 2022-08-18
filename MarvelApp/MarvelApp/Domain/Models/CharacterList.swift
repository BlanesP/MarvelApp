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
    struct Character {
        let id: Int
        let name: String
        let description: String?
        let icon: URL
    }
}
