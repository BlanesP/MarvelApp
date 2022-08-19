//
//  ComicRequestMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation
@testable import MarvelApp

extension ComicRequest.Response {
    static var mock: Self {
        ComicRequest.Response(
            data: ComicDataContainer(
                results: [
                    Comic(
                        id: 1,
                        title: "Title",
                        description: "Description",
                        thumbnail: nil,
                        urls: []
                    )
                ]
            )
        )
    }
}
