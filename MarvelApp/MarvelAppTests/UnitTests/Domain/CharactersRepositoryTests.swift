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

    //MARK: - Comic

    func testFetchComicSuccess() {
        //Given
        let mock = ComicRequest.Response.mock
        dataSource.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchComic(id: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.data!.results!.first!.id)
    }

    func testFetchComicFailure() {
        //Given
        dataSource.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchComic(id: 1)
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

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }

    //MARK: - Fetch event

    func testFetchEventSuccess() {
        //Given
        let mock = EventRequest.Response.mock
        dataSource.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchEvent(id: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.data!.results!.first!.id)
    }

    func testFetchEventFailure() {
        //Given
        dataSource.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchEvent(id: 1)
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

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }

    //MARK: - Fetch serie

    func testFetchSerieSuccess() {
        //Given
        let mock = SerieRequest.Response.mock
        dataSource.result = mock
        var result: CharacterItem?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchSerie(id: 1)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { result = $0 }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, mock.data!.results!.first!.id)
    }

    func testFetchSerieFailure() {
        //Given
        dataSource.result = BasicError(message: "Mock error")
        var result: CharacterItem?
        var error: Error?
        let expectation = self.expectation(description: "success")

        //When
        repository
            .fetchSerie(id: 1)
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

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }

    //MARK: - Characters

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

        waitForExpectations(timeout: 0.1)

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

        waitForExpectations(timeout: 0.1)

        //Then
        XCTAssertNil(result)
        XCTAssertNotNil(error)
    }
}
