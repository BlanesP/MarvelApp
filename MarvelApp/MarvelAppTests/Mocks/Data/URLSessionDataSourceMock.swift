//
//  URLSessionDataSourceMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
@testable import MarvelApp

final class URLSessionDataSourceMock: BaseMock {
    var result: Any?
}

extension URLSessionDataSourceMock: URLSessionDataSource {
    func fetchComic(input: ComicRequest.Input, id: String) -> AnyPublisher<ComicRequest.Response, Error> {
        mockPublisherResult()
    }

    func fetchEvent(input: EventRequest.Input, id: String) -> AnyPublisher<EventRequest.Response, Error> {
        mockPublisherResult()
    }

    func fetchSerie(input: SerieRequest.Input, id: String) -> AnyPublisher<SerieRequest.Response, Error> {
        mockPublisherResult()
    }

    func fetchCharacters(input: CharactersRequest.Input) -> AnyPublisher<CharactersRequest.Response, Error> {
        mockPublisherResult()
    }
}
