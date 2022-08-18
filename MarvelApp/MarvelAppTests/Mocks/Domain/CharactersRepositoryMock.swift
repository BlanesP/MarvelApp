//
//  CharactersRepositoryMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
@testable import MarvelApp

final class CharactersRepositoryMock: BaseMock {
    var result: Any?
}

extension CharactersRepositoryMock: CharactersRepository {
    func fetchCharacters(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error> {
        mockPublisherResult()
    }
}
