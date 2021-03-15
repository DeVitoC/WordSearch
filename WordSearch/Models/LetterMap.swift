//
//  Graph.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/2/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class LetterMap {
    var head: Node
    var lastNodeAdded: Coordinate
    var size: Int
    var numWords: Int
    var values: [Coordinate : Node]
    var coordinateRange: CoordinateRange
    var wordCoords: [String : (Coordinate, Coordinate)] = [:]


    init(word: [Character], direction: Direction) {
        let firstNode = Node(value: word[0], coord: .zero)

        self.head = firstNode
        self.lastNodeAdded = firstNode.coord
        self.size = 1
        self.numWords = 1
        self.values = [.zero : firstNode]
        self.coordinateRange = .zero
        addFirstWord(word: word, direction: direction)
    }

    @discardableResult func add(value: Character, direction: Direction, relativeTo coord: Coordinate) -> Node {
        let coordinate: Coordinate
        switch direction {
            case .above:
                coordinate = coord.above
            case .below:
                coordinate = coord.below
            case .before:
                coordinate = coord.before
            case .after:
                coordinate = coord.after
        }

        let newNode = Node(value: value, coord: coordinate)
        if values[newNode.coord] != nil {
            return newNode
        }

        if let node = values[coord] {
            node.connections[direction] = newNode
            newNode.connections[direction.opposite] = node
        }
        coordinateRange.expandIfOutside(coord: coordinate)
        values[newNode.coord] = newNode
        size += 1

        return newNode
    }

    func addFirstWord(word: [Character], direction: Direction) {

        let remainingWord = Array(word[1..<word.count])

        for char in remainingWord {
            let newNode = add(value: char, direction: direction, relativeTo: lastNodeAdded)
            lastNodeAdded = newNode.coord
        }
        wordCoords[String(word)] = (Coordinate(x: 0, y: 0), lastNodeAdded)
    }

    func addWordIfFits(word: [Character]) -> Bool {
        for char in 0..<word.count {
            let possibleIntersectionPoints = getPossibleIntersectionPoints(char: word[char])
            for (node, coord) in possibleIntersectionPoints {
                let axis = node.checkConnections()
                if !testWordFits(word: word,
                                 baseCoord: coord,
                                 axis: axis,
                                 charIndex: char) {
                    continue
                }
                lastNodeAdded = coord
                var startCoord: Coordinate
                if axis == .horizontal {
                    for i in 0..<char {
                        guard values[lastNodeAdded.before] == nil else {
                            lastNodeAdded = lastNodeAdded.before
                            continue
                        }
                        let newNode = add(value: word[char - 1 - i],
                                          direction: .before,
                                          relativeTo: lastNodeAdded)
                        lastNodeAdded = newNode.coord
                    }
                    startCoord = lastNodeAdded
                    lastNodeAdded = coord
                    for i in 1..<(word.count - char) {
                        guard values[lastNodeAdded.after] == nil else {
                            lastNodeAdded = lastNodeAdded.after
                            continue
                        }
                        let newNode = add(value: word[char + i], direction: .after, relativeTo: lastNodeAdded)
                        lastNodeAdded = newNode.coord
                    }
                } else if axis == .vertical {
                    for i in 0..<char {
                        guard values[lastNodeAdded.above] == nil else {
                            lastNodeAdded = lastNodeAdded.above
                            continue
                        }
                        let newNode = add(value: word[char - 1 - i],
                                          direction: .above,
                                          relativeTo: lastNodeAdded)
                        lastNodeAdded = newNode.coord
                    }
                    startCoord = lastNodeAdded
                    lastNodeAdded = coord
                    for i in 1..<(word.count - char) {
                        guard values[lastNodeAdded.below] == nil else {
                            lastNodeAdded = lastNodeAdded.below
                            continue
                        }
                        let newNode = add(value: word[char + i], direction: .below, relativeTo: lastNodeAdded)
                        lastNodeAdded = newNode.coord
                    }
                } else {
                    continue
                }
                numWords += 1
                wordCoords[String(word)] = (startCoord, lastNodeAdded)
                return true

            }
        }
        return false
    }

    func getPossibleIntersectionPoints(char: Character) -> [Node : Coordinate] {
        var coords: [Node : Coordinate] = [:]
        for (coord, node) in values where node.value == char {
            coords[node] = coord
        }
        return coords
    }

    func getValue(coordinate: Coordinate) -> Character {
        if let node = values[coordinate] {
            return node.value
        } else {
            return "0"
        }
    }

    func testWordFits(word: [Character], baseCoord: Coordinate, axis: Axis, charIndex: Int) -> Bool {
        let firstPart = Array(word[0..<charIndex])
        let secondPart = Array(word[(charIndex + 1)..<word.count])
        if axis == .horizontal {
            for i in 1...firstPart.count + 1 {
                let testCoord = Coordinate(x: (baseCoord.x - i), y: baseCoord.y)
                if getValue(coordinate: testCoord.above) == "0",
                    getValue(coordinate: testCoord.below) == "0",
                    (getValue(coordinate: testCoord) == "0" ||
                        getValue(coordinate: testCoord) == word[charIndex]) {
                    continue
                } else {
                    return false
                }
            }
            if getValue(coordinate: Coordinate(x: (baseCoord.x - firstPart.count - 1), y: baseCoord.y)) != "0" {
                return false
            }
            for i in 1...secondPart.count + 1 {
                let testCoord = Coordinate(x: (baseCoord.x + i), y: baseCoord.y)
                if getValue(coordinate: testCoord.above) == "0",
                    getValue(coordinate: testCoord.below) == "0",
                    (getValue(coordinate: testCoord) == "0" ||
                        getValue(coordinate: testCoord) == word[charIndex]) {
                    continue
                } else {
                    return false
                }
            }
            if getValue(coordinate: Coordinate(x: (baseCoord.x + secondPart.count + 1), y: baseCoord.y)) != "0" {
                return false
            }
        } else if axis == .vertical {
            for i in 1...firstPart.count + 1 {
                let testCoord = Coordinate(x: baseCoord.x, y: (baseCoord.y + i))
                if getValue(coordinate: testCoord.before) == "0",
                    getValue(coordinate: testCoord.after) == "0",
                    (getValue(coordinate: testCoord) == "0" ||
                        getValue(coordinate: testCoord) == word[charIndex]) {
                    continue
                } else {
                    return false
                }
            }
            if getValue(coordinate: Coordinate(x: baseCoord.x, y: (baseCoord.y + firstPart.count + 1))) != "0" {
                return false
            }
            for i in 1...secondPart.count + 1 {
                let testCoord = Coordinate(x: baseCoord.x, y: (baseCoord.y - i))
                if getValue(coordinate: testCoord.before) == "0",
                    getValue(coordinate: testCoord.after) == "0",
                    (getValue(coordinate: testCoord) == "0" ||
                        getValue(coordinate: testCoord) == word[charIndex]) {
                    continue
                } else {
                    return false
                }
            }
            if getValue(coordinate: Coordinate(x: baseCoord.x, y: (baseCoord.y - secondPart.count - 1))) != "0" {
                return false
            }
        } else {
            return false
        }
        return true
    }
}
