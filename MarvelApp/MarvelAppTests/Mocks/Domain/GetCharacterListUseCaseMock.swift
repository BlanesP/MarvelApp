//
//  GetCharacterListUseCaseMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
@testable import MarvelApp

final class GetCharacterListUseCaseMock: BaseMock {
    var result: Any?
}

extension GetCharacterListUseCaseMock: GetCharacterListUseCase {
    func execute(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error> {
        mockPublisherResult()
    }
}
