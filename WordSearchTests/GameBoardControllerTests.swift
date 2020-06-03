//
//  GameBoardControllerTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 5/28/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class GameBoardControllerTests: XCTestCase {

    let gameBoardController = GameBoardController()

    func testGameSizeForLevel() throws {
        var levelSize = gameBoardController.gameSizeForLevel(level: 1)
        XCTAssertEqual(levelSize, 4)
        levelSize = gameBoardController.gameSizeForLevel(level: 101)
        XCTAssertEqual(levelSize, 5)
        levelSize = gameBoardController.gameSizeForLevel(level: 201)
        XCTAssertEqual(levelSize, 6)
        levelSize = gameBoardController.gameSizeForLevel(level: 501)
        XCTAssertEqual(levelSize, 7)
        levelSize = gameBoardController.gameSizeForLevel(level: 1001)
        XCTAssertEqual(levelSize, 8)
        levelSize = gameBoardController.gameSizeForLevel(level: 2001)
        XCTAssertEqual(levelSize, 9)
        levelSize = gameBoardController.gameSizeForLevel(level: 3001)
        XCTAssertEqual(levelSize, 10)
        levelSize = gameBoardController.gameSizeForLevel(level: 4001)
        XCTAssertEqual(levelSize, 11)
        levelSize = gameBoardController.gameSizeForLevel(level: 5001)
        XCTAssertEqual(levelSize, 12)
        levelSize = gameBoardController.gameSizeForLevel(level: 6001)
        XCTAssertEqual(levelSize, 13)
        levelSize = gameBoardController.gameSizeForLevel(level: 7001)
        XCTAssertEqual(levelSize, 14)
        levelSize = gameBoardController.gameSizeForLevel(level: 8001)
        XCTAssertEqual(levelSize, 15)
        levelSize = gameBoardController.gameSizeForLevel(level: 9001)
        XCTAssertEqual(levelSize, 16)
        levelSize = gameBoardController.gameSizeForLevel(level: 10001)
        XCTAssertEqual(levelSize, 17)
        levelSize = gameBoardController.gameSizeForLevel(level: 11001)
        XCTAssertEqual(levelSize, 18)
        levelSize = gameBoardController.gameSizeForLevel(level: 12001)
        XCTAssertEqual(levelSize, 19)
    }

    func testGenerateWordmap() {
        let gameBoard = GameBoard(word: Word(mainWord: "fallow", anagrams: ["loaf", "allow", "foal", "fall", "wall", "wolf", "flow", "flaw", "awl", "low", "law", "fowl", ], searchWords: [], bonusWords: ["fowl", "loaf", "allow", "foal", "fall", "wall", "wolf", "flow", "flaw", "awl", "low", "law"]))
        let wordMap = gameBoardController.generateWordMap(gameBoard: gameBoard)
        var numberOfLettersInWordMap: Int = 0
        let widthOfWordMap = gameBoard.word.mainWord.count * 2 + 1
        let numberOfSpacesInWordMap = widthOfWordMap * widthOfWordMap
        for y in 0..<widthOfWordMap {
            for x in 0..<widthOfWordMap {
                if wordMap[y][x] != nil {
                    numberOfLettersInWordMap += 1
                }
            }
        }
        XCTAssert(numberOfLettersInWordMap > numberOfSpacesInWordMap/3)
    }

    func testCreateGameboard() {
        for _ in 0...10 {
            let gameBoard = gameBoardController.createGameBoard(level: 201)
            XCTAssert(gameBoard.foundWords.count == 0)
            XCTAssert(gameBoard.remainingWords.count > 0)
            XCTAssert(gameBoard.word.mainWord.count == 6)
            XCTAssert(gameBoard.remainingWords.contains(gameBoard.word.mainWord))
            XCTAssert(gameBoard.word.anagrams.count > 0)
            XCTAssert(gameBoard.word.searchWords.count == 0)
            XCTAssert(gameBoard.word.bonusWords.count > 0)
        }
    }
}
