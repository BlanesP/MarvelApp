//
//  URLSessionDataSource.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import Foundation

protocol URLSessionDataSource {
    func fetchCharacters(input: CharactersRequest.Input) -> AnyPublisher<CharactersRequest.Response, Error>
}

final class URLSessionDataSourceImpl: Logger { }

extension URLSessionDataSourceImpl: URLSessionDataSource {

    func fetchCharacters(input: CharactersRequest.Input) -> AnyPublisher<CharactersRequest.Response, Error> {
        log("Fetching characters...")

        return GETRequest(
            for: Endpoint(baseURL: .marvel, request: .characters, params: input)
        )
    }
}

//MARK: - Utils

private extension URLSessionDataSourceImpl {
    func GETRequest<T: Decodable>(for endpoint: Endpoint) -> AnyPublisher<T, Error> {

        guard let url = endpoint.buildGETURL() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

