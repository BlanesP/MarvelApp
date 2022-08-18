//
//  CharactersRepository.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine

protocol CharactersRepository {
    func fetchCharacters(page: Int, pageSize: Int) -> AnyPublisher<CharacterList, Error>
}
