//
//  GetCharacterListUseCase.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine

protocol GetCharacterListUseCase {
    func execute(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error>
}

final class GetCharacterListUseCaseImpl: Logger {
    let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository = repository
    }
}

extension GetCharacterListUseCaseImpl: GetCharacterListUseCase {
    func execute(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error> {
        log("Executing use case...")

        return repository.fetchCharacters(page: page, pageSize: pageSize)
    }
}
