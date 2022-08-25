//
//  SerieRequestMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation
@testable import MarvelApp

extension SerieRequest.Response {
    static var mock: Self {
        SerieRequest.Response(
            data: SerieDataContainer(
                results: [
                    Serie(
                        id: UUID().hashValue,
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
