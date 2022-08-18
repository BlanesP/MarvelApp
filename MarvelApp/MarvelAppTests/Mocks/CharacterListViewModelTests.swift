//
//  CharacterListViewModelTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import XCTest
@testable import MarvelApp

class CharacterListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let useCase = GetCharacterListUseCaseMock()
    private lazy var viewModel = CharacterListViewModel(useCase: useCase)

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    func testFetchSuccess() {
        //Given
        let mock = CharacterList.mock
        useCase.result = mock
        var result = [CharacterListViewModel.ViewOutput]()
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

        viewModel.input(.fetchData(refresh: true))

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .ready])
        XCTAssertEqual(viewModel.characters.count, mock.characters.count)
    }

    func testFetchError() {
        //Given
        useCase.result = BasicError(message: "Mock error")
        var result = [CharacterListViewModel.ViewOutput]()
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

        viewModel.input(.fetchData(refresh: true))

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .error])
        XCTAssertTrue(viewModel.characters.isEmpty)
    }

    func testFetchMoreSuccess() {
        //Given
        let mock = CharacterList.mock
        useCase.result = mock
        var result = [CharacterListViewModel.ViewOutput]()
        let firstExpectation = self.expectation(description: "fetch success")
        let secondExpectation = self.expectation(description: "fetch more success")

        //When
        viewModel
            .output
            .sink(
                receiveValue: {
                    result.append($0)
                    if result == [.loading, .ready] {
                        firstExpectation.fulfill()
                    } else if result == [.loading, .ready, .loadingMore, .ready] {
                        secondExpectation.fulfill()
                    }
                }
            )
            .store(in: &cancellables)

        viewModel.input(.fetchData(refresh: true))
        wait(for: [firstExpectation], timeout: 0.1)
        viewModel.input(.fetchData(refresh: false))
        wait(for: [secondExpectation], timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .ready, .loadingMore, .ready])
        XCTAssertEqual(viewModel.characters.count, mock.characters.count * 2)
    }

    func testFetchMoreFailure() {
        //Given
        let mock = CharacterList.mock
        useCase.result = mock
        var result = [CharacterListViewModel.ViewOutput]()
        let firstExpectation = self.expectation(description: "fetch success")
        let secondExpectation = self.expectation(description: "fetch more failure")

        //When
        viewModel
            .output
            .sink(
                receiveValue: {
                    result.append($0)
                    if result == [.loading, .ready] {
                        firstExpectation.fulfill()
                    } else if result == [.loading, .ready, .loadingMore, .ready] {
                        secondExpectation.fulfill()
                    }
                }
            )
            .store(in: &cancellables)

        viewModel.input(.fetchData(refresh: true))
        wait(for: [firstExpectation], timeout: 0.1)
        useCase.result = BasicError(message: "Mock error")
        viewModel.input(.fetchData(refresh: false))
        wait(for: [secondExpectation], timeout: 0.1)

        //Then
        XCTAssertEqual(result, [.loading, .ready, .loadingMore, .ready]) //if pagination fails we just hide loader
        XCTAssertEqual(viewModel.characters.count, mock.characters.count)
    }
}
