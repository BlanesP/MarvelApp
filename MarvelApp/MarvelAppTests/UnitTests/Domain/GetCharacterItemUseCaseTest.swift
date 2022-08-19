//
//  GetCharacterItemUseCaseTest.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import XCTest

import Combine
import XCTest
@testable import MarvelApp

class GetCharacterItemUseCaseTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private let repository = CharactersRepositoryMock()
    private lazy var useCase = GetCharacterItemUseCaseImpl(repository: repository)

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    //MARK: - Comic

    func testExecuteComicSuccess() {
        //Given
        let mock = CharacterItem.mock(for: .comic)
        repository.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        useCase
            .execute(comicId: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.id)
    }

    func testExecuteComicFailure() {
        //Given
        repository.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "failure")

        //When
        useCase
            .execute(comicId: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let e) = completion {
                        error = e
                    }
                    expectation.fulfill()
                },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }

    //MARK: - Event

    func testExecuteEventSuccess() {
        //Given
        let mock = CharacterItem.mock(for: .event)
        repository.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        useCase
            .execute(eventId: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.id)
    }

    func testExecuteEventFailure() {
        //Given
        repository.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "failure")

        //When
        useCase
            .execute(eventId: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let e) = completion {
                        error = e
                    }
                    expectation.fulfill()
                },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }

    //MARK: - Serie

    func testExecuteSerieSuccess() {
        //Given
        let mock = CharacterItem.mock(for: .serie)
        repository.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        useCase
            .execute(serieId: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.id)
    }

    func testExecuteSerieFailure() {
        //Given
        repository.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "failure")

        //When
        useCase
            .execute(serieId: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let e) = completion {
                        error = e
                    }
                    expectation.fulfill()
                },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }
}

