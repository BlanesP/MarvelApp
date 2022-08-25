//
//  CharacterRowViewTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 25/8/22.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MarvelApp

private extension View {
    func toUIView() -> UIView {
        UIHostingController(rootView: self).view
    }
}

class CharacterRowViewTests: XCTestCase {

    func testCharacterRow() {
        let rowView = CharacterRowView(character: CharacterList.Character.mock)
        let view = rowView.toUIView()

        assertSnapshot(
            matching: view,
            as: .wait(for: 1, on: .image(size: view.intrinsicContentSize))
        )
    }

    func testCharacterRowNoEvents() {
        let character = CharacterList.Character(
            id: UUID().hashValue,
            name: "Name",
            iconUrl: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            comics: [CharacterItem.mock(for: .comic)],
            stories: [CharacterItem.mock(for: .story), CharacterItem.mock(for: .story), CharacterItem.mock(for: .story)],
            events: [],
            series: [CharacterItem.mock(for: .serie), CharacterItem.mock(for: .serie)]
        )
        let rowView = CharacterRowView(character: character)
        let view = rowView.toUIView()

        assertSnapshot(
            matching: view,
            as: .wait(for: 1, on: .image(size: view.intrinsicContentSize))
        )
    }

    func testCharacterRowLoading() {
        let rowView = CharacterRowView(character: CharacterList.Character.mock)
        let view = rowView.toUIView()

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }
}
