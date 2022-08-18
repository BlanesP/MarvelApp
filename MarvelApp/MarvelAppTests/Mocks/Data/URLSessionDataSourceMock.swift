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
    func fetchCharacters(input: CharactersRequest.Input) -> AnyPublisher<CharactersRequest.Response, Error> {
        mockPublisherResult()
    }
}
