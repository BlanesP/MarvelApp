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
            imageUrl: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/58dbce634ea70.jpg")!,
            detailUrl: URL(
                string: "https://marvel.com/comics/issue/21366/avengers_the_initiative_2007_14?utm_campaign=apiRef&utm_source=7ddd4dc418f8d5ace7e32bda025539a7"
            )!
        )
    }
}
