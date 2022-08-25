//
//  CharacterItemViewTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 25/8/22.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MarvelApp

class CharacterItemViewTests: XCTestCase {

    private let useCase = GetCharacterItemUseCaseMock()
    private var vc: UIViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()

        let vm = CharacterItemViewModel(item: CharacterItem.mock(for: .comic), useCase: useCase)
        let characterItemView = CharacterItemView(viewModel: vm, attribution: "An attribution")
        vc = UIHostingController(rootView: characterItemView)

        vc!.beginAppearanceTransition(true, animated: false)
        vc!.endAppearanceTransition()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
      vc = nil
    }

    func testCharacterItemViewLoading() {
        assertSnapshot(
            matching: vc!,
            as: .image(on: .iPhone12)
        )
    }

    func testCharacterItemView() {
        assertSnapshot(
            matching: vc!,
            as: .wait(for: 1, on: .image(on: .iPhone12))
        )
    }
}
