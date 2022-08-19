//
//  CharacterItemViewModelTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import Combine
import XCTest
@testable import MarvelApp

class CharacterItemViewModelTests: XCTestCase {

    private let item = CharacterItem.mock(for: .comic)
    private var cancellables = Set<AnyCancellable>()
    private let useCase = GetCharacterItemUseCaseMock()
    private lazy var viewModel = CharacterItemViewModel(item: item, useCase: useCase)

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    func testFetchSuccess() {
        //Given
        let mock = CharacterItem.mock(for: .comic)
        useCase.result = mock
        var result = [CharacterItemViewModel.ViewOutput]()
        let expectation = self.expectation(description: "success")

        //When
        viewModel
            .output
            .sink(
                receiveValue: {
                    result.append($0)
                    if $0 != .loading {
                        expectation.fulfill()
                    }
                }
            )
            .store(in: &cancellables)

        viewModel.input(.fetchData)

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .ready])
    }

    func testFetchError() {
        //Given
        useCase.result = BasicError(message: "Mock error")
        var result = [CharacterItemViewModel.ViewOutput]()
        let expectation = self.expectation(description: "failure")

        //When
        viewModel
            .output
            .sink(
                receiveValue: {
                    result.append($0)
                    if $0 != .loading {
                        expectation.fulfill()
                    }
                }
            )
            .store(in: &cancellables)

        viewModel.input(.fetchData)

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .error])
    }

}
