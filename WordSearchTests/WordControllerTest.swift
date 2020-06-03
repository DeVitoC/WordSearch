//
//  WordControllerTest.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class WordControllerTest: XCTestCase {

    let wordController = WordController()

    func testCreateWord() {
        for _ in 0...1000 {
        let word = wordController.createWord(maxSize: 6)
        XCTAssert(word.anagrams.count > 0)
        XCTAssert(word.bonusWords.count > 0)
        XCTAssert(word.mainWord.count == 6)
        XCTAssert(word.searchWords.count == 0)
        }
    }

}
