//
//  CoordinateTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class CoordinateTests: XCTestCase {

    let coord1 = Coordinate(x: 0, y: 0)
    let coord2 = Coordinate(x: 0, y: 0)
    let coord3 = Coordinate(x: 1, y: 0)

    func testEquals() throws {
        XCTAssert(coord1 == coord2)
        XCTAssertFalse(coord1 == coord3)
    }


}
