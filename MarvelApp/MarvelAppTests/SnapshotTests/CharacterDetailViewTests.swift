//
//  CharacterDetailViewTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 25/8/22.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MarvelApp

class CharacterDetailViewTests: XCTestCase {

    private var vc: UIViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()

        let characterDetailView = CharacterDetailView(
            character: CharacterList.Character.mock,
            attribution: "An attribution"
        )
        vc = UIHostingController(rootView: characterDetailView)

        vc!.beginAppearanceTransition(true, animated: false)
        vc!.endAppearanceTransition()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
      vc = nil
    }

    func testCharacterDetailView() {
        assertSnapshot(
            matching: vc!,
            as: .wait(for: 1, on: .image(on: .iPhone12))
        )
    }
}
