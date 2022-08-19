//
//  GetCharacterListUseCaseTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import XCTest
@testable import MarvelApp

class GetCharacterListUseCaseTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private let repository = CharactersRepositoryMock()
    private lazy var useCase = GetCharacterListUseCaseImpl(repository: repository)

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    func testExecuteSuccess() {
        //Given
        let mock = CharacterList.mock
        repository.result = mock
        var result: CharacterList?
        let expectation = self.expectation(description: "success")

        //When
        useCase
            .execute(page: 0, pageSize: 15)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.characters.count, mock.characters.count)
    }

    func testExecuteFailure() {
        //Given
        repository.result = BasicError(message: "Mock error")
        var result: CharacterList?
        var error: Error?
        let expectation = self.expectation(description: "failure")

        //When
        useCase
            .execute(page: 0, pageSize: 15)
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
