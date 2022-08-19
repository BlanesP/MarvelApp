//
//  StringUtilsTests.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import XCTest
@testable import MarvelApp

class StringUtilsTests: XCTestCase {

    func testMD5() {
        let expectedResult = "ffd275c5130566a2916217b101f26150"
        let result = "1abcd1234".md5

        XCTAssertEqual(expectedResult, result)
    }

    func testSecureUrl() {
        let expectedResult = "https://www.apple.com"
        let result = "http://www.apple.com".secureUrl

        XCTAssertEqual(expectedResult, result)
    }
}
