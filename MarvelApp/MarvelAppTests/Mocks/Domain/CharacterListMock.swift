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
                Character(
                    id: 1,
                    name: "Name",
                    icon: URL(string: "https://www.a.com")!,
                    comics: [],
                    stories: [],
                    events: [],
                    series: []
                )
            ]
        )
    }
}
