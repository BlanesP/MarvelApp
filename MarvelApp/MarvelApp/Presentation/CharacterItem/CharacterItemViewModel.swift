//
//  CharacterItemViewModel.swift
//  MarvelApp
//
//  Created by Pau Blanes on 19/8/22.
//

import Foundation
import Combine

final class CharacterItemViewModel: ObservableObject {
    @Published var item: CharacterItem
    let output = PassthroughSubject<ViewOutput, Never>()

    private lazy var cancellables = Set<AnyCancellable>()
    private let useCase: GetCharacterItemUseCase

    init(item: CharacterItem, useCase: GetCharacterItemUseCase) {
        self.item = item
        self.useCase = useCase
    }

    deinit {
        cancellables.removeAll()
    }
}

//MARK: - View Comunication

extension CharacterItemViewModel {

    func input(_ input: ViewInput) {
        switch input {
        case .fetchData where item.type != .story:
            fetchItem()
        default:
            break
        }
    }

    enum ViewInput {
        case fetchData
    }

    enum ViewOutput {
        case loading
        case ready
        case error
    }
}

//MARK: - Private methods

private extension CharacterItemViewModel {
    func fetchItem() {

        guard let publisher = getItemPublisher() else { return }

        output.send(.loading)

        publisher
            .subscribe(on: .global)
            .receive(on: .main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.output.send(.error)
                    } else {
                        self?.output.send(.ready)
                    }
                },
                receiveValue: { [weak self] in
                    self?.item = $0
                }
            )
            .store(in: &cancellables)
    }

    func getItemPublisher() -> AnyPublisher<CharacterItem, Error>? {
        switch item.type {
        case .comic:
            return useCase.execute(comicId: item.id)
        case .event:
            return useCase.execute(eventId: item.id)
        case .serie:
            return useCase.execute(serieId: item.id)
        default:
            return nil
        }
    }
}
