//
//  MarvelAppUITests.swift
//  MarvelAppUITests
//
//  Created by Pau Blanes on 19/8/22.
//

import XCTest

class MarvelAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app.launch()
    }

    func testTitle() {
        let title = app.staticTexts["All Marvel Characters!"]

        XCTAssert(title.waitForExistence(timeout: 10))
    }

    func testNavigation() {
        let row = app.tables.buttons.firstMatch
        XCTAssert(row.waitForExistence(timeout: 10))
        row.tapUnhittable() //Needed to avoid random isHittable == false

        app.navigationBars.buttons.firstMatch.tap()
    }
}

//MARK: - Utils

extension XCUIElement {
    func tapUnhittable() {
        XCTContext.runActivity(named: "Tap \(self) by coordinate") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }
}
