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
            XCTAssert(letterMap.values[letterMap.lastNodeAdded]?.value == "e")
            XCTAssert(letterMap.head.value == "m")
            XCTAssert(letterMap.size == 6)
            XCTAssert(letterMap.values.count == 6)
        }

    }

    func testAdd() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "t", direction: .above, relativeTo: letterMap.lastNodeAdded.above)
            XCTAssert(letterMap.coordinateRange.high == Coordinate(x: 5, y: 2))
            XCTAssert(letterMap.coordinateRange.low == Coordinate(x: 0, y: 0))
            XCTAssert(letterMap.values[letterMap.lastNodeAdded.above.above]?.value == "t")
            XCTAssert(letterMap.size == 8)
            XCTAssert(letterMap.lastNodeAdded.above.above == Coordinate(x: 5, y: 2))
            XCTAssert(letterMap.values.count == 8)
        }
    }

    func testGetValue() {
        for _ in 0...10 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "t", direction: .above, relativeTo: letterMap.lastNodeAdded.above)
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 0, y: 0)) == "m")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 1, y: 0)) == "o")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 2, y: 0)) == "t")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 3, y: 0)) == "i")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 4, y: 0)) == "v")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 0)) == "e")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 1)) == "o")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 5, y: 2)) == "t")
            XCTAssert(letterMap.getValue(coordinate: Coordinate(x: 3, y: 3)) == "0")
            XCTAssert(letterMap.values.count == 8)
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
        for _ in 0...1000 {
            let mainWord: [Character] = ["m", "o", "t", "i", "v", "e"]
            let letterMap = LetterMap(word: mainWord, direction: .after)
            letterMap.add(value: "o", direction: .above, relativeTo: letterMap.lastNodeAdded)
            letterMap.add(value: "m", direction: .above, relativeTo: letterMap.lastNodeAdded.above)
            let word: [Character] = ["m", "o", "t", "e"]
            let word2: [Character] = ["m", "i", "t", "e"]
            let word3: [Character] = ["v", "o", "t", "e"]
            let shouldAddWord = letterMap.addWordIfFits(word: word)
            XCTAssert(shouldAddWord)
            XCTAssert(letterMap.size == 11)
            let shouldAddWord2 = letterMap.addWordIfFits(word: word2)
            XCTAssert(shouldAddWord2)
            XCTAssert(letterMap.size == 14)
            let shouldAddWord3 = letterMap.addWordIfFits(word: word3)
            XCTAssert(shouldAddWord3)
            XCTAssert(letterMap.size == 17)

            NSLog("\(letterMap.size)")

        }
    }
}
