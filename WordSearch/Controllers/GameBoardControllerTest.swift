//
//  GameBoardControllerTest.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/2/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class GameBoardControllerTest {
    // MARK: - Properties
    let wordController = WordController()
    var word: Word?

    // Mark: - CRUD Methods
    func createGameBoard(level: Int) -> GameBoard {
        let gameSize = gameSizeForLevel(level: level)
        word = wordController.createWord(maxSize: gameSize)
        guard let word = word else { fatalError("Word object not created correctly") }
        let gameBoard = GameBoard(word: word)
        return gameBoard
    }

    func createWordMap(gameBoard: GameBoard) {
        var wordMap: Graph
    }

    // Mark: - Helper Methods
    func gameSizeForLevel(level: Int) -> Int {
        // Return a max word size based on level
        switch level {
            case 1...100:
                return 4
            case 101...200:
                return 5
            case 201...500:
                return 6
            case 501...1000:
                return 7
            case 1001...2000:
                return 8
            case 2001...3000:
                return 9
            case 3001...4000:
                return 10
            case 4001...5000:
                return 11
            case 5001...6000:
                return 12
            case 6001...7000:
                return 13
            case 7001...8000:
                return 14
            case 8001...9000:
                return 15
            case 9001...10_000:
                return 16
            case 10_001...11_000:
                return 17
            case 11_001...12_000:
                return 18
            default:
                return 19
        }
    }
}
