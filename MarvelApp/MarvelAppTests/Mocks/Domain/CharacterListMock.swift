//
//  CharacterListMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation
@testable import MarvelApp

extension CharacterList {
    static var mock: Self {
        CharacterList(
            total: 2,
            attributionText: "An attribution",
            characters: [
                Character.mock
            ]
        )
    }
}

extension CharacterList.Character {
    static var mock: Self {
        CharacterList.Character(
            id: UUID().hashValue,
            name: "Name",
            iconUrl: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            comics: [CharacterItem.mock(for: .comic)],
            stories: [CharacterItem.mock(for: .story), CharacterItem.mock(for: .story), CharacterItem.mock(for: .story)],
            events: [CharacterItem.mock(for: .event)],
            series: [CharacterItem.mock(for: .serie), CharacterItem.mock(for: .serie)]
        )
    }
}
