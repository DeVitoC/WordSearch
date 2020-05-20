//
//  GameBoardController.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class GameBoardController {
    // MARK: - Properties
    let wordController = WordController()

    // MARK: - CRUD Methods
    func createGameBoard(level: Int) -> GameBoard {
        let gameSize = gameSizeForLevel(level: level)
        let word = wordController.createWord(maxSize: gameSize)
        let gameBoard = GameBoard(word: word)
        return gameBoard
    }

    // TODO: - Possibly move this method to another class if method gets too complicated.
    // TODO: - Definitely refactor into smaller chunks of code if possible.
    func generateWordMap(gameBoard: GameBoard) -> [[Character?]] {
        var wordMap: [[Character?]] = [[]]
        // Populate wordMap with nil as a starter
        for array in 0...gameBoard.word.mainWord.count * 2 {
            if array > 0 {
                wordMap.append([])
            }
            for _ in 0...gameBoard.word.mainWord.count * 2 {
                wordMap[array].append(nil)
            }
        }

        // create and populate an array of arrays of the characters from the search words
        var searchWords: [[Character]] = [[]]
        for word in gameBoard.word.searchWords {
            let array: [Character] = Array(word)
            searchWords.append(array)
        }

        // if axis is true, word is horizontal, otherwise it's vertical
        var axis: Bool = Bool.random()

        // the x and y values of the first letter of the first word to use for generating wordMap
        let xVal = Int.random(in: 0...gameBoard.word.mainWord.count)
        let yVal = Int.random(in: 0...gameBoard.word.mainWord.count)

        // set first word in wordMap based on direction indicated by axis
        // remove word from temporary searchWords array and toggle axis to alternating direction
        if axis {
            for charNumber in 0..<searchWords[searchWords.count - 1].count {
                wordMap[yVal][xVal + charNumber] = searchWords[searchWords.count - 1][charNumber]
            }
            searchWords.remove(at: searchWords.count - 1)
            axis.toggle()
        } else {
            for charNumber in 0..<searchWords[searchWords.count - 1].count {
                wordMap[yVal + charNumber][xVal] = searchWords[searchWords.count - 1][charNumber]
            }
            searchWords.remove(at: searchWords.count - 1)
            axis.toggle()
        }

        // add additional words to wordMap
        for word in searchWords {
            // randomly choose which letter to intersect and create array of tuples to store possible intersection points
            let intersectingChar = Int.random(in: 0..<word.count)
            var possibleIntersectionPoints: [(Int, Int)] = []

            // find possible intersection points and store in possibleIntersectionPoints array
            for y in 0..<wordMap.count {
                for x in 0..<wordMap.count {
                    if wordMap[y][x] == word[intersectingChar]
                        && axis
                        && wordMap[y - 1][x] == nil
                        && wordMap[y + 1][x] == nil {
                        possibleIntersectionPoints.append((y, x))
                    } else if wordMap[y][x] == word[intersectingChar]
                        && !axis
                        && wordMap[y][x - 1] == nil
                        && wordMap[y][x + 1] == nil {
                        possibleIntersectionPoints.append((y, x))
                    }
                }
            }

            // iterates through word to attempt to place characters in wordMap
            // probably should be placed in a throwing method
            for character in 0..<word.count {
                if character == intersectingChar {
                    continue
                } else if axis {
                    // TODO: - Work on this logic for attempting to place a char. probably need to test if nil so we don't overwrite an existing character
                    wordMap[possibleIntersectionPoints[0].0][possibleIntersectionPoints[0].1 - intersectingChar + character] = word[character]
                } else {

                }
            }
        }
        return wordMap
    }

    // MARK: - Helper Methods
    func gameSizeForLevel(level: Int) -> Int {
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
