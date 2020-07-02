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
    let wordController = WordController() // An object of the WordController class to create a Word object
    var word: Word? // An optional to assign the created Word object to. Assigned in createGameBoard method.

    // MARK: - CRUD Methods

    // Checked - looks good
    func createGameBoard(level: Int) -> GameBoard {
        let gameSize = gameSizeForLevel(level: level) // Determine size of word based on level
        word = wordController.createWord(maxSize: gameSize) // Create Word object based on gameSize
        guard let word = word else { fatalError() } // Unwrap word
        let gameBoard = GameBoard(word: word) // Create a GameBoard object with the Word object
        return gameBoard
    }

    func createWordMap(gameBoard: GameBoard) -> [[Character?]] {
        var wordMap: [[Character?]] = populateWordMapWithNil(size: gameBoard.word.mainWord.count) // Populate wordMap with nil
        var axis: Bool = Bool.random() // if axis is true, word is horizontal, otherwise it's vertical

        wordMap = setFirstWordInWordMap(mainWord: gameBoard.word.mainWord, axis: axis, wordMap: wordMap) // Set mainword as first word in wordmap
        addSearchWord(searchWord: gameBoard.word.mainWord) // Add mainword to searchWords and remove from bonusWords
        axis.toggle() // Alternates axis after first word is set in word map

        for _ in 0...5 { // Iterates 6 times through to attempt to create a full gameBoard
            // create and populate an array of arrays of the characters from the search words
            var searchWords: [[Character]] = createSearchWordsCharacterArray(searchWords: gameBoard.word.bonusWords)

            (wordMap, axis, searchWords) = getWordsToAddToMap(searchWords: searchWords, wordMap: wordMap, axis: axis, gameBoard: gameBoard)
            if checkWordMapIsFull(wordMap: wordMap, mainWord: gameBoard.word.mainWord) {
                break // If checkWordMapIsFull returns true (i.e. wordMap has enough words) break loop and return wordmap
            }
        }
        return wordMap
    }

    // MARK: - Helper Methods

    // Checked - looks good
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

    // Checked - looks good
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

    // Checked - looks good
    func createSearchWordsCharacterArray(searchWords: [String]) -> [[Character]] {
        var searchWordsChar: [[Character]] = [[]]
        for word in searchWords {
            let array: [Character] = Array(word)
            searchWordsChar.append(array)
        }
        searchWordsChar.remove(at: 0)

        return searchWordsChar
    }

    // Checked - looks good
    func setFirstWordInWordMap(mainWord: String, axis: Bool, wordMap: [[Character?]]) -> [[Character?]] {
        let mainWord: [Character] = Array.init(mainWord)
        var wordMap = wordMap
        let mapSize = wordMap.count
        // the x and y values of the first letter of the first word to use for generating wordMap
        let xVal = Int.random(in: mapSize/5...(axis ? mainWord.count : (mainWord.count*2 - mapSize/5)))
        let yVal = Int.random(in: mapSize/5...(!axis ? mainWord.count : (mainWord.count*2 - mapSize/5)))

        // set first word into wordMap starting at (xVal, yVal)
        for charNumber in 0..<mainWord.count {
            if axis {
                wordMap[yVal][xVal + charNumber] = mainWord[charNumber]
            } else {
                wordMap[yVal + charNumber][xVal] = mainWord[charNumber]
            }
        }

        addSearchWord(searchWord: String(mainWord))
        return wordMap
    }

    // Checked - looks good
    func addSearchWord(searchWord: String) {
        guard let index = word?.bonusWords.firstIndex(of: searchWord) else { return }
        if let isInSearchWords = word?.searchWords.contains(searchWord), !isInSearchWords {
            word?.searchWords.append(searchWord)
        }
        if let isInBonusWords = word?.bonusWords.contains(searchWord), isInBonusWords {
            word?.bonusWords.remove(at: index)
        }
    }

    // Checked - looks good
    func getWordsToAddToMap(searchWords: [[Character]], wordMap: [[Character?]], axis: Bool, gameBoard: GameBoard) -> ([[Character?]], Bool, [[Character]]) {
        var wordMap = wordMap
        var axis = axis
        var searchWordsVar = searchWords
        words: for _ in 0..<searchWords.count  { // Iterate through as many words are there are in searchWords
            searchWordsVar.shuffle() // Shuffle words to randomize the order words are checked
            guard let word = searchWordsVar.popLast() else { fatalError() } // Remove a word from searchWordsVar to try to add to wordMap
            // randomly choose which letters to intersect and create array of tuples to store possible intersection points
            let intersectingChars: [Int] = generateIntersectingChars(word: word) // Generate 3 chars from the word to use as possible anchors
            let possibleIntersectionPoints = generateIntersectionPoints(wordMap: wordMap, axis: axis, intersectingChars: intersectingChars, word: word) // generates a list of possible points on the wordMap where word might intersect - needs to be examined again

            // iterates through word to attempt to place characters in wordMap
            possiblePointsLoop: for (charValue, points) in possibleIntersectionPoints { // Iterate through the possible intersection points to test if word will fit, seperate
                var points = points // assign constant points to a var
                for _ in 0..<points.count { // iterate through points
                    let point = points[points.count - 1] // set point to the last point in the set
                    points.remove(at: points.count - 1) // remove last point from set
                    if checkWordFits(point: point, intersectingChar: charValue, axis: axis, wordMap: wordMap, word: word) { // check if the word fits at the intersection point
                        wordMap = addWordsToWordMap(point: point, intersectingChar: charValue, axis: axis, wordMap: wordMap, word: word) // if word fits, add to word map
                        axis.toggle() // toggle axis - possibly add both directions to intersection point and eliminate this
                        let joinedWord = String(word)
                        addSearchWord(searchWord: joinedWord)
                        if checkWordMapIsFull(wordMap: wordMap, mainWord: gameBoard.word.mainWord) { // if word is added, check if it fills wordmap criteria
                            break words
                        }
                        break possiblePointsLoop // if word fits, stop checking points and continue to next word
                    }
                }
            }
        }
        return (wordMap, axis, searchWords)
    }

    // Checked - looks good
    func generateIntersectingChars(word: [Character]) -> [Int] {
        var intersectingChars: [Int] = []
        var tempRandomNumberArray: [Int] = []
        for i in 0..<word.count { tempRandomNumberArray.append(i) }

        for _ in 0...2 {
            tempRandomNumberArray.shuffle()
            intersectingChars.append(tempRandomNumberArray[0])
            tempRandomNumberArray.remove(at: 0)
        }
        return intersectingChars
    }

    func generateIntersectionPoints(wordMap: [[Character?]],
                                    axis: Bool,
                                    intersectingChars: [Int], word: [Character]) -> [Int : [(Int, Int)]] {
        // create array of tuples to store possible intersection points
        var possibleIntersectionPoints: [Int : [(Int, Int)]] = [ : ]

        // find possible intersection points and store in possibleIntersectionPoints array
        for i in intersectingChars {
            possibleIntersectionPoints[i] = []
            possiblePoint: for y in 0..<wordMap.count {
                for x in 0..<wordMap.count where wordMap[y][x] == word[i] {
                    if (!axis
                        && y == 0
                        && wordMap[y + 1][x] == nil)
                        || (axis
                            && x == 0
                            && wordMap[y][x + 1] == nil) {
                        possibleIntersectionPoints[i]?.append((y, x))
                        continue
                    }

                    if x == 0 || y == 0 { continue possiblePoint }

                    if (!axis
                        && wordMap[y - 1][x] == nil
                        && wordMap[(y >= (wordMap.count - 1) ? y - 1 : y + 1)][x] == nil)
                        || (axis
                            && wordMap[y][x - 1] == nil
                            && wordMap[y][(x >= (wordMap.count - 1) ? x - 1 : x + 1)] == nil) {
                        possibleIntersectionPoints[i]?.append((y, x))
                    }
                }
            }
        }
        return possibleIntersectionPoints
    }

    func addWordsToWordMap(point: (Int, Int),
                           intersectingChar: Int,
                           axis: Bool,
                           wordMap: [[Character?]],
                           word: [Character]) -> [[Character?]]{

        var wordMap = wordMap
        let rangeStart = axis ? (point.1 - intersectingChar) : (point.0 - intersectingChar)
        if axis {
            for x in 0..<word.count {
                wordMap[point.0][rangeStart + x] = word[x]
            }
        } else {
            for y in 0..<word.count {
                wordMap[rangeStart + y][point.1] = word[y]
            }
        }
        return wordMap
    }

    // Checked - looks good
    func checkWordMapIsFull(wordMap: [[Character?]],
                            mainWord: String) -> Bool {
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
        return numberOfLettersInWordMap > numberOfSpacesInWordMap/5
    }


    func checkWordFits(point: (Int, Int),
                             intersectingChar: Int,
                             axis: Bool,
                             wordMap: [[Character?]],
                             word: [Character]) -> Bool {
        let rangeStart = axis ? (point.1 - intersectingChar) : (point.0 - intersectingChar)
        let rangeEnd = rangeStart + word.count
        guard rangeStart >= 1, rangeEnd < ((wordMap.count)) else { return false }

        if axis {
            if wordMap[point.0][rangeStart - 1] != nil ||
                wordMap[point.0][rangeEnd] != nil {
                return false
            }

            for x in rangeStart..<rangeEnd {
                if (x - rangeStart) == intersectingChar { continue }
                if wordMap[point.0][x] != nil ||
                    wordMap[point.0 - 1][x] != nil ||
                    wordMap[point.0 + 1][x] != nil {
                    return false
                }
            }
        } else {
            if wordMap[rangeStart - 1][point.1] != nil ||
                wordMap[rangeEnd][point.1] != nil {
                return false
            }

            for y in rangeStart..<rangeEnd {
                if y == intersectingChar { continue }
                if wordMap[y][point.1] != nil ||
                    wordMap [y][point.1 - 1] != nil ||
                    wordMap[y][point.1 + 1] != nil {
                    return false
                }
            }
        }
        return true
    }
}
