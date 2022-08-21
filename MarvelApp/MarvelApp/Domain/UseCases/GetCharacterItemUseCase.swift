//
//  GetCharacterItemUseCase.swift
//  MarvelApp
//
//  Created by Pau Blanes on 19/8/22.
//

import Combine

protocol GetCharacterItemUseCase {
    func execute(comicId: Int) -> AnyPublisher<CharacterItem, Error>
    func execute(eventId: Int) -> AnyPublisher<CharacterItem, Error>
    func execute(serieId: Int) -> AnyPublisher<CharacterItem, Error>
}

final class GetCharacterItemUseCaseImpl: Logger {
    let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository = repository
    }
}

extension GetCharacterItemUseCaseImpl: GetCharacterItemUseCase {
    func execute(comicId: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Executing use case...")

        return repository.fetchComic(id: comicId)
    }

    func execute(eventId: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Executing use case...")

        return repository.fetchEvent(id: eventId)
    }

    func execute(serieId: Int) -> AnyPublisher<CharacterItem, Error> {
        log("Executing use case...")

        return repository.fetchSerie(id: serieId)
    }
}
