//
//  GetCharacterItemUseCaseMock.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Combine
@testable import MarvelApp

final class GetCharacterItemUseCaseMock: BaseMock {
    var result: Any?
}

extension GetCharacterItemUseCaseMock: GetCharacterItemUseCase {
    func execute(comicId: Int) -> AnyPublisher<CharacterItem, Error> {
        mockPublisherResult()
    }

    func execute(eventId: Int) -> AnyPublisher<CharacterItem, Error> {
        mockPublisherResult()
    }

    func execute(serieId: Int) -> AnyPublisher<CharacterItem, Error> {
        mockPublisherResult()
    }
}
