//
//  LetterMapTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class LetterMapTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testLetterMapInit()  {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            XCTAssert(letterMap.coordinateRange.high == Coordinate(x: 5, y: 0))
            XCTAssert(letterMap.coordinateRange.low == Coordinate(x: 0, y: 0))
            XCTAssert(letterMap.lastNodeAdded.value == "e")
            XCTAssert(letterMap.head.value == "m")
            XCTAssert(letterMap.size == 6)
            XCTAssert(letterMap.values["m"]?.count == 1)
            XCTAssert(letterMap.values["o"]?.count == 1)
            XCTAssert(letterMap.values["t"]?.count == 1)
            XCTAssert(letterMap.values["i"]?.count == 1)
            XCTAssert(letterMap.values["v"]?.count == 1)
            XCTAssert(letterMap.values["e"]?.count == 1)
        }

    }

    func testAdd() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "t", direction: .above, relativeTo: letterMap.lastNodeAdded)
            XCTAssert(letterMap.coordinateRange.high == Coordinate(x: 5, y: 2))
            XCTAssert(letterMap.coordinateRange.low == Coordinate(x: 0, y: 0))
            XCTAssert(letterMap.lastNodeAdded.value == "t")
            XCTAssert(letterMap.size == 8)
            XCTAssert(letterMap.lastNodeAdded.coord == Coordinate(x: 5, y: 2))
            XCTAssert(letterMap.values["m"]?.count == 1)
            XCTAssert(letterMap.values["o"]?.count == 2)
            XCTAssert(letterMap.values["t"]?.count == 2)
            XCTAssert(letterMap.values["i"]?.count == 1)
            XCTAssert(letterMap.values["v"]?.count == 1)
            XCTAssert(letterMap.values["e"]?.count == 1)
        }
    }

    func testGetValue() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "t", direction: .above, relativeTo: letterMap.lastNodeAdded)
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 0, y: 0)) == "m")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 1, y: 0)) == "o")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 2, y: 0)) == "t")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 3, y: 0)) == "i")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 4, y: 0)) == "v")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 0)) == "e")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 1)) == "o")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 2)) == "t")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 3, y: 3)) == "0")
            XCTAssert(letterMap.values["m"]?.count == 1)
            XCTAssert(letterMap.values["o"]?.count == 2)
            XCTAssert(letterMap.values["t"]?.count == 2)
            XCTAssert(letterMap.values["i"]?.count == 1)
            XCTAssert(letterMap.values["v"]?.count == 1)
            XCTAssert(letterMap.values["e"]?.count == 1)
        }
    }

    func testTestWordFits() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "t", direction: .above, relativeTo: letterMap.lastNodeAdded)
            let word: [Character] = ["m", "o", "t", "e"]
            let shouldFit = letterMap.testWordFits(word: word, baseCoord: Coordinate(x: 1, y: 0), axis: .vertical, charIndex: 1)
            let word2: [Character] = ["m", "o", "v", "e"]
            let shouldNotFit = letterMap.testWordFits(word: word2, baseCoord: Coordinate(x: 4, y: 0), axis: .vertical, charIndex: 2)
            XCTAssert(shouldFit)
            XCTAssert(!shouldNotFit)
        }
    }

    func testAddWordIfFits() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "m", direction: .above, relativeTo: letterMap.lastNodeAdded)
            let word: [Character] = ["m", "o", "t", "e"]
            let shouldAddWord = letterMap.addWordIfFits(word: word)
            XCTAssert(shouldAddWord)
            XCTAssert(letterMap.values["m"]?.count == 2)
            XCTAssert(letterMap.values["o"]?.count == 3)
            XCTAssert(letterMap.values["t"]?.count == 2)
            XCTAssert(letterMap.values["i"]?.count == 1)
            XCTAssert(letterMap.values["v"]?.count == 1)
            XCTAssert(letterMap.values["e"]?.count == 2)
            XCTAssert(letterMap.size == 11)
        }
    }
}
