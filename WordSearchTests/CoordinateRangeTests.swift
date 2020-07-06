//
//  CoordinateRangeTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class CoordinateRangeTests: XCTestCase {

    var coordinateRange = CoordinateRange(high: Coordinate(x: 3, y: 3), low: Coordinate(x: 0, y: 0))
    let coord1 = Coordinate(x: 4, y: 2)
    let coord2 = Coordinate(x: 2, y: 4)
    let coord3 = Coordinate(x: -1, y: 0)
    let coord4 = Coordinate(x: 0, y: -1)

    func testExpandIfOutside() throws {
        coordinateRange.expandIfOutside(coord: coord1)
        XCTAssert(coordinateRange.high == Coordinate(x: 4, y: 3))
        coordinateRange.expandIfOutside(coord: coord2)
        XCTAssert(coordinateRange.high == Coordinate(x: 4, y: 4))
        coordinateRange.expandIfOutside(coord: coord3)
        XCTAssert(coordinateRange.low == Coordinate(x: -1, y: 0))
        coordinateRange.expandIfOutside(coord: coord4)
        XCTAssert(coordinateRange.low == Coordinate(x: -1, y: -1))
    }

}
