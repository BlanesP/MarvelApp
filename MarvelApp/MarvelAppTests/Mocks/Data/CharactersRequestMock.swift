//
//  CharactersRequestMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation
@testable import MarvelApp

extension CharactersRequest.Response {
    static var mock: Self {
        CharactersRequest.Response(
            attributionText: "",
            data: CharacterDataContainer(
                total: 1,
                results: [
                    Character(
                        id: 1,
                        name: "Name",
                        thumbnail: Image(
                            path: "https://www.a.com",
                            extension: "jpg"
                        ),
                        comics: ComicList(items: []),
                        stories: StoryList(items: []),
                        events: EventList(items: []),
                        series: SeriesList(items: [])
                    )
                ]
            )
        )
    }
}
