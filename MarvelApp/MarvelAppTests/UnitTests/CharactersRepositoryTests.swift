//
//  CharactersRepositoryTests.swift
//  CharactersRepositoryTests
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import XCTest
@testable import MarvelApp

class CharactersRepositoryTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private let dataSource = URLSessionDataSourceMock()
    private lazy var repository = CharactersRepositoryImpl(dataSource: dataSource)

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    func testFetchCharactersSuccess() {
        //Given
        let mock = CharactersRequest.Response.mock
        dataSource.result = mock
        var result: CharacterList?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchCharacters(page: 0, pageSize: 15)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.characters.count, mock.data!.results!.count)
    }

    func testFetchCharactersFailure() {
        //Given
        dataSource.result = BasicError(message: "Mock error")
        var result: CharacterList?
        var error: Error?
        let expectation = self.expectation(description: "failure")

        //When
        repository
            .fetchCharacters(page: 0, pageSize: 15)
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
