//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine

final class CharacterListViewModel: ObservableObject, Logger {
    @Published var characters = [CharacterList.Character]()
    let output = PassthroughSubject<ViewOutput, Never>()

    private lazy var cancellables = Set<AnyCancellable>()
    private let pagination = Pagination()
    private let useCase: GetCharacterListUseCase

    init(useCase: GetCharacterListUseCase) {
        self.useCase = useCase
    }
}

//MARK: - View Comunication

extension CharacterListViewModel {

    func input(_ input: ViewInput) {
        switch input {
        case .fetchData(let refresh) where pagination.canFetchMore:
            fetchCharacters(refresh: refresh)
        default:
            break
        }
    }

    enum ViewInput {
        case fetchData(refresh: Bool)
    }

    enum ViewOutput {
        case loading
        case loadingMore
        case ready
        case error
    }
}

//MARK: - Private methods

private extension CharacterListViewModel {
    func fetchCharacters(refresh: Bool) {

        pagination.isFetching = true
        output.send(refresh ? .loading : .loadingMore)

        useCase
            .execute(page: pagination.page, pageSize: pagination.pageSize)
            .subscribe(on: .global)
            .receive(on: .main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.pagination.isFetching = false
                    if case .failure = completion, refresh {
                        self?.output.send(.error)
                    } else {
                        self?.output.send(.ready)
                    }
                },
                receiveValue: { [weak self] result in
                    if refresh {
                        self?.characters = result.characters
                    } else {
                        self?.characters.append(contentsOf: result.characters)
                    }

                    self?.pagination.currentCount = self?.characters.count ?? 0
                    self?.pagination.totalCount = result.total
                }
            )
            .store(in: &cancellables)
    }
}

//MARK: - Components

private extension CharacterListViewModel {
    final class Pagination {
        let pageSize = 15

        var isFetching = false
        var currentCount = 0
        var totalCount = 0

        var page: Int {
            currentCount / pageSize
        }

        var canFetchMore: Bool {
            if totalCount == 0 && !isFetching { return true }

            return !isFetching && currentCount < totalCount
        }
    }
}
