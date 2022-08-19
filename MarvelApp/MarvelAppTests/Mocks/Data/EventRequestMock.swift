//
//  EventRequestMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation
@testable import MarvelApp

extension EventRequest.Response {
    static var mock: Self {
        EventRequest.Response(
            data: EventDataContainer(
                results: [
                    Event(
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
