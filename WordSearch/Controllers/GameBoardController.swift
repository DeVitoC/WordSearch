//
//  GameBoardControllerTest.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/2/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class GameBoardController {
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

    func createLetterMap(gameBoard: GameBoard) -> LetterMap {
        var letterMap: LetterMap

        letterMap = setFirstWordInLetterMap(mainWord: gameBoard.word.mainWord)
        addSearchWord(searchWord: gameBoard.word.mainWord)

        let searchWords: [[Character]] = createSearchWordsArray(searchWords: gameBoard.word.bonusWords)
        // Check each word in searchWords
        addWordsToMapIfFit(searchWords: searchWords, letterMap: letterMap, mainWordSize: gameBoard.word.mainWord.count)
        // Check if map is full

        return letterMap
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

    func setFirstWordInLetterMap(mainWord: String) -> LetterMap {
        let mainWord: [Character] = .init(mainWord)
        let axis: Bool = Bool.random()
        let direction: Direction = axis ? .after : .below
        let letterMap = LetterMap(word: mainWord, direction: direction)

        return letterMap
    }

    func addSearchWord(searchWord: String) {
        guard let index = word?.bonusWords.firstIndex(of: searchWord) else { return }
        if let isInSearchWords = word?.searchWords.contains(searchWord), !isInSearchWords {
            word?.searchWords.append(searchWord)
        }
        if let isInBonusWords = word?.bonusWords.contains(searchWord), isInBonusWords {
            word?.bonusWords.remove(at: index)
        }
    }

    func createSearchWordsArray(searchWords: [String]) -> [[Character]] {
        var searchWordsChar: [[Character]] = [[]]
        for word in searchWords {
            let array: [Character] = Array(word)
            searchWordsChar.append(array)
        }
        searchWordsChar.remove(at: 0)

        return searchWordsChar
    }

    func addWordsToMapIfFit(searchWords: [[Character]], letterMap: LetterMap, mainWordSize size: Int) {
        var searchWordsVar = searchWords
        var searchWordsCount = 1
        for i in 1...(size - 3) {
            searchWordsVar.shuffle()
            var searchArray: [[Character]] = []
            for word in searchWordsVar where word.count == (size - i) {
                searchArray.append(word)
            }
            for _ in 0..<searchArray.count {
                guard let currentWord = searchArray.popLast() else {
                    fatalError()
                }
                let didAddWord = letterMap.addWordIfFits(word: currentWord)
                if didAddWord {
                    addSearchWord(searchWord: String(currentWord))
                    searchWordsCount += 1
                }
            }
            if searchWordsCount > (size * 2) {
                return
            }
        }
    }
}
