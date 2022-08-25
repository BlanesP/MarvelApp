//
//  CharacterItemMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation
@testable import MarvelApp

extension CharacterItem {
    static func mock(for type: CharacterItem.ItemType) -> Self {
        CharacterItem(
            id: UUID().hashValue,
            title: "Title",
            type: type,
            description: "Description",
            imageUrl: nil,
            detailUrl: nil
        )
    }
}
