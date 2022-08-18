//
//  ViewFactory.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

struct ViewFactory {
    private let domainFactory = DomainFactory()

    var characterListView: CharacterListView {
        CharacterListView(
            viewModel: CharacterListViewModel(useCase: domainFactory.characterListUseCase)
        )
    }
}

private extension ViewFactory {
    struct DomainFactory {
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
