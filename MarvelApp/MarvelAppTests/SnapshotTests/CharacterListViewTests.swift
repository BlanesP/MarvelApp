//
//  CharacterListViewTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 25/8/22.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MarvelApp

class CharacterListViewTests: XCTestCase {

    private let useCase = GetCharacterListUseCaseMock()
    private lazy var vm = CharacterListViewModel(useCase: useCase)
    private var vc: UIViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()

        let characterListView = CharacterListView(viewModel: vm)
        vc = UIHostingController(rootView: characterListView)

        vc!.beginAppearanceTransition(true, animated: false)
        vc!.endAppearanceTransition()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
      vc = nil
    }

    func testCharacterListViewLoading() {
        assertSnapshot(
            matching: vc!,
            as: .image(on: .iPhone12)
        )
    }

    func testCharacterListView() {
        useCase.result = CharacterList.mock

        assertSnapshot(
            matching: vc!,
            as: .wait(for: 1, on: .image(on: .iPhone12))
        )
    }
}
