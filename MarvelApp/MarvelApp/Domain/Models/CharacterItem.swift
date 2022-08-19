//
//  CharacterItem.swift
//  MarvelApp
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation

struct CharacterItem {
    let id: Int
    let title: String
    let type: ItemType
    var description: String?
    var imageUrl: URL?
    var detailUrl: URL?
}

extension CharacterItem {
    enum ItemType {
        case comic, story, serie, event
    }
}
