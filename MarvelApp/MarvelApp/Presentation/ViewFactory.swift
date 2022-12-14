//
//  ViewFactory.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

struct ViewFactory {
    private let domainFactory = DomainFactory()

    var characterListView: some View {
        CharacterListView(
            viewModel: CharacterListViewModel(useCase: domainFactory.characterListUseCase)
        )
    }

    func characterDetailView(for character: CharacterList.Character, attribution: String) -> some View {
        CharacterDetailView(character: character, attribution: attribution)
    }

    func characterItemView(for item: CharacterItem, attribution: String) -> some View {
        CharacterItemView(
            viewModel: CharacterItemViewModel(
                item: item,
                useCase: domainFactory.characterItemUseCase
            ),
            attribution: attribution
        )
    }
}

private extension ViewFactory {
    struct DomainFactory {
        var characterItemUseCase: GetCharacterItemUseCase {
            GetCharacterItemUseCaseImpl(repository: charactersRepository)
        }

        var characterListUseCase: GetCharacterListUseCase {
            GetCharacterListUseCaseImpl(repository: charactersRepository)
        }

        private let charactersRepository: CharactersRepository = CharactersRepositoryImpl(
            dataSource: URLSessionDataSourceImpl()
        )
    }
}

//MARK: - Environment

struct ViewFactoryKey: EnvironmentKey {
    static let defaultValue = ViewFactory()
}

extension EnvironmentValues {
    var viewFactory: ViewFactory { self[ViewFactoryKey.self] }
}
