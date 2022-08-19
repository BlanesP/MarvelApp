//
//  ChainedExpectation.swift
//  MarvelAppTests
//
//  Created by Pau Blanes on 19/8/22.
//

import XCTest

final class ChainedExpectation: XCTestExpectation {

    var expectationCount = 1
    let ignoreLast: Bool

    init(description: String, totalExpectations: Int, ignoreLast: Bool) {
        self.ignoreLast = ignoreLast
        super.init(description: description)
        self.expectedFulfillmentCount = totalExpectations
    }

    func fulfill(completion: (Int) -> Void) {
        if (expectationCount < self.expectedFulfillmentCount) || !ignoreLast {
            completion(expectationCount)
        }
        
        if expectationCount < self.expectedFulfillmentCount {
            expectationCount += 1
        }

        self.fulfill()
    }
}
