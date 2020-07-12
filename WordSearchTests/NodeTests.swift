//
//  NodeTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class NodeTests: XCTestCase {

    let node1 = Node(value: "H", coord: Coordinate(x: 1, y: 1))
    let node2 = Node(value: "H", coord: Coordinate(x: 1, y: 1))
    let node3 = Node(value: "G", coord: Coordinate(x: 0, y: 1))
    let node4 = Node(value: "I", coord: Coordinate(x: 1, y: 0))

    func testEquals() {
        XCTAssert(node1 == node2)
        XCTAssertFalse(node1 == node3)
    }

    func testCheckConnections() {
        node1.connections[.before] = node3
        node3.connections[.after] = node1
        node1.connections[.below] = node4
        node4.connections[.above] = node1
        XCTAssert(node1.checkConnections() == .notAvailable)
        XCTAssert(node3.checkConnections() == .vertical)
        XCTAssert(node4.checkConnections() == .horizontal)
    }


}
