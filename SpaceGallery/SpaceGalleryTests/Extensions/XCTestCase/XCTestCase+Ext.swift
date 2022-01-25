//
//  XCTestCase+Ext.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import XCTest

extension XCTestCase {
    private static let timeoutForExpectations: TimeInterval = 5.0

    func waitForExpectations(expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: Self.timeoutForExpectations)
    }
}
