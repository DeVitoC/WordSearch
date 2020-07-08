//
//  GameBoardControllerTestTests.swift
//  WordSearchTests
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import XCTest
@testable import WordSearch

class GameBoardControllerTestTests: XCTestCase {

    var gameBoardController: GameBoardControllerTest?
    var gameBoard: GameBoard?

    override func setUp() {
        super.setUp()
        gameBoardController = GameBoardControllerTest()
        gameBoard = gameBoardController?.createGameBoard(level: 201)
    }

    func testCreateGameboard() {
        for _ in 0...10 {
            gameBoard = gameBoardController?.createGameBoard(level: 201)
            XCTAssert(gameBoard?.foundWords.count == 0)
            XCTAssert((gameBoard?.remainingWords.count)! > 0)
            XCTAssert(gameBoard?.word.mainWord.count == 6)
            XCTAssert((gameBoard?.remainingWords.contains((gameBoard?.word.mainWord)!)) != nil)
            XCTAssert((gameBoard?.word.anagrams.count)! > 0)
            XCTAssert(gameBoard?.word.searchWords.count == 0)
            XCTAssert((gameBoard?.word.bonusWords.count)! > 0)
        }
    }

    func testCreateWordMap() {
        for _ in 0...10 {
            gameBoard = gameBoardController?.createGameBoard(level: 201)
            let letterMap = gameBoardController?.createWordMap(gameBoard: gameBoard!)
            guard let size = letterMap?.size, let numWords = letterMap?.numWords else { return }
            NSLog("\(size)")
            NSLog("\(numWords)")
            XCTAssert((letterMap?.size)! > 20)
        }
    }

    func testGameSizeForLevel() {
        guard let gameBoardController = gameBoardController else { fatalError() }
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

    func testAddSearchWord() {
        let word = (gameBoard?.word.bonusWords.randomElement())!
        gameBoardController?.addSearchWord(searchWord: word)
        guard let bonusWords = gameBoard?.word.bonusWords.contains(word),
            let searchWords = gameBoard?.word.searchWords.contains(word) else { return }
        XCTAssertFalse(bonusWords)
        XCTAssert(searchWords)
    }

    func testAddWordsToMapIfFit() {
        for _ in 0...10 {
            let gameBoard = GameBoard(word: Word(mainWord: "fallow", anagrams: ["loaf", "allow", "foal", "fall", "wall", "wolf", "flow", "flaw", "awl", "low", "law", "fowl", ], searchWords: [], bonusWords: ["fowl", "loaf", "allow", "foal", "fall", "wall", "wolf", "flow", "flaw", "awl", "low", "law"]))
            let wordMap = LetterMap(word: ["f", "a", "l", "l", "o", "w"], direction: .after)
            var searchWords: [[Character]] = []
            for word in gameBoard.word.bonusWords {
                let searchWord: [Character] = Array(word)
                searchWords.append(searchWord)
            }

            gameBoardController?.addWordsToMapIfFit(searchWords: searchWords, wordMap: wordMap, mainWordSize: gameBoard.word.mainWord.count)
            NSLog("WordMap size: \(wordMap.size)")
            let numWords = wordMap.numWords
            NSLog("\(numWords)")
            XCTAssert(wordMap.values.count >= 20)
        }
    }


}
