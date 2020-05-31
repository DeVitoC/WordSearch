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
        // Populate wordMap with nil as a starter
        var wordMap: [[Character?]] = populateWordMapWithNil(size: gameBoard.word.mainWord.count)

        // create and populate an array of arrays of the characters from the search words
        let searchWords: [[Character]] = createSearchWordsCharacterArray(searchWords: gameBoard.word.anagrams)

        // if axis is true, word is horizontal, otherwise it's vertical
        var axis: Bool = Bool.random()

        // set first word in wordMap based on direction indicated by axis and then toggle axis
        wordMap = setFirstWordInWordMap(mainWord: gameBoard.word.mainWord, axis: axis, wordMap: wordMap)
        axis.toggle()

        // iterate through searchWords to add additional words to wordMap 
        for word in searchWords  {
            //let word = searchWords[searchWords.count - 1]
            //searchWords.remove(at: searchWords.count - 1)

            // randomly choose which letter to intersect and create array of tuples to store possible intersection points
            let intersectingChar = Int.random(in: 0..<word.count)
            var possibleIntersectionPoints = generateIntersectionPoints(wordMap: wordMap, axis: axis, intersectingChar: word[intersectingChar])

            // iterates through word to attempt to place characters in wordMap
            for _ in 0..<possibleIntersectionPoints.count {
                let point = possibleIntersectionPoints[possibleIntersectionPoints.count - 1]
                possibleIntersectionPoints.remove(at: possibleIntersectionPoints.count - 1)
                guard let tempWordMap = addWordsToWordMap(point: point, intersectingChar: intersectingChar, axis: axis, wordMap: wordMap, word: word) else {
                    continue
                }
                wordMap = tempWordMap
                axis.toggle()
                let joinedWord = String(word)
                wordController.addSearchWord(searchWord: joinedWord)
                break
            }
            if checkWordMapIsFull(wordMap: wordMap, mainWord: gameBoard.word.mainWord) {
                break
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

    func populateWordMapWithNil(size: Int) -> [[Character?]] {
        var wordMap: [[Character?]] = [[]]
        for array in 0...size * 2 {
            if array > 0 {
                wordMap.append([])
            }
            for _ in 0...size * 2 {
                wordMap[array].append(nil)
            }
        }

        return wordMap
    }

    func createSearchWordsCharacterArray(searchWords: [String]) -> [[Character]] {
        var searchWordsChar: [[Character]] = [[]]
        for word in searchWords {
            let array: [Character] = Array(word)
            searchWordsChar.append(array)
        }
        searchWordsChar.remove(at: 0)

        return searchWordsChar
    }

    func setFirstWordInWordMap(mainWord: String, axis: Bool, wordMap: [[Character?]]) -> [[Character?]] {
        let mainWord: [Character] = Array.init(mainWord)
        var wordMap = wordMap
        // the x and y values of the first letter of the first word to use for generating wordMap
        let xVal = Int.random(in: 0...mainWord.count)
        let yVal = Int.random(in: 0...mainWord.count)

        // set first word into wordMap starting at (xVal, yVal)
        for charNumber in 0..<mainWord.count {
            if axis {
                wordMap[yVal][xVal + charNumber] = mainWord[charNumber]
            } else {
                wordMap[yVal + charNumber][xVal] = mainWord[charNumber]
            }
        }

        return wordMap
    }

    func generateIntersectionPoints(wordMap: [[Character?]], axis: Bool, intersectingChar: Character) -> [(Int, Int)] {
        // create array of tuples to store possible intersection points
        var possibleIntersectionPoints: [(Int, Int)] = []

        // find possible intersection points and store in possibleIntersectionPoints array
        possiblePoint: for y in 0..<wordMap.count {
            for x in 0..<wordMap.count where wordMap[y][x] == intersectingChar {
                if !axis
                    && y == 0
                    && wordMap[y + 1][x] == nil {
                    possibleIntersectionPoints.append((y, x))
                    continue
                } else if axis
                    && x == 0
                    && wordMap[y][x + 1] == nil {
                    possibleIntersectionPoints.append((y, x))
                    continue
                }

                if x == 0 || y == 0 { continue possiblePoint }

                if !axis
                    && wordMap[y - 1][x] == nil
                    && wordMap[y + 1][x] == nil {
                    possibleIntersectionPoints.append((y, x))
                } else if axis
                    && wordMap[y][x - 1] == nil
                    && wordMap[y][x + 1] == nil {
                    possibleIntersectionPoints.append((y, x))
                }
            }
        }
        return possibleIntersectionPoints
    }

    func addWordsToWordMap(point: (Int, Int), intersectingChar: Int, axis: Bool, wordMap: [[Character?]], word: [Character]) -> [[Character?]]?{
        var wordMap = wordMap
        if (point.1 < intersectingChar && axis)
            || (point.0 < intersectingChar && !axis)
            || (wordMap.count - point.1 - 1 < word.count - intersectingChar && axis)
            || (wordMap.count - point.0 - 1 < word.count - intersectingChar && !axis) {
            return nil
        }
        if axis {
            for num in (point.1 - intersectingChar)...(point.1 + word.count - 1 - intersectingChar) {
                if (point.1 != num && (wordMap[point.0][num] != nil))
                    || (point.1 != num && wordMap[point.0 - 1][num] != nil)
                    || (point.1 != num && wordMap[point.0 + 1][num] != nil) {
                    return nil
                }
            }
            for character in 0..<word.count {
                let x = point.1 - intersectingChar + character
                wordMap[point.0][x] = word[character]
            }
        } else if !axis {
            for num in (point.0 - intersectingChar)...(point.0 + word.count - 1 - intersectingChar) {
                if point.0 != num && (wordMap[num][point.1] != nil)
                    || (point.1 != num && point.0 >= 1 && wordMap[point.0 - 1][num] != nil)
                    || (point.1 != num && point.0 >= 1 && wordMap[point.0 + 1][num] != nil)  {
                    return nil
                }
            }
            for character in 0..<word.count {
                let y = point.0 - intersectingChar + character
                wordMap[y][point.1] = word[character]
            }
        }
        return wordMap
    }

    func checkWordMapIsFull(wordMap: [[Character?]], mainWord: String) -> Bool {
        var numberOfLettersInWordMap: Int = 0
        let widthOfWordMap = mainWord.count * 2 + 1
        let numberOfSpacesInWordMap = widthOfWordMap * widthOfWordMap
        for y in 0..<widthOfWordMap {
            for x in 0..<widthOfWordMap {
                if wordMap[y][x] != nil {
                    numberOfLettersInWordMap += 1
                }
            }
        }
        return numberOfLettersInWordMap > numberOfSpacesInWordMap/4
    }
}
