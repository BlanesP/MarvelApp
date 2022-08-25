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

    //MARK: - Comic

    func testFetchComicSuccess() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Comic", type: .comic)
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
        XCTAssertEqual(viewModel.item.type, .comic)
        XCTAssertEqual(viewModel.item.title, mock.title)
    }

    func testFetchComicFailure() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Comic", type: .comic)
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

    //MARK: - Event

    func testFetchEventSuccess() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Event", type: .event)
        let mock = CharacterItem.mock(for: .event)
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
        XCTAssertEqual(viewModel.item.type, .event)
        XCTAssertEqual(viewModel.item.title, mock.title)
    }

    func testFetchEventFailure() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Event", type: .event)
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

    //MARK: - Serie

    func testFetchSerieSuccess() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Serie", type: .serie)
        let mock = CharacterItem.mock(for: .serie)
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
        XCTAssertEqual(viewModel.item.type, .serie)
        XCTAssertEqual(viewModel.item.title, mock.title)
    }

    func testFetchSerieFailure() {
        //Given
        viewModel.item = CharacterItem(id: UUID().hashValue, title: "Serie", type: .serie)
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
