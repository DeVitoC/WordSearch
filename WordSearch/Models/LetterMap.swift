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
    var lastNodeAdded: Node
    var size: Int
    var numWords: Int
    var values: [Character : [Node: Coordinate]]
    var coordinateRange: CoordinateRange

    init(word: [Character], direction: Direction) {
        let firstNode = Node(value: word[0], coord: .zero)
        self.head = firstNode
        self.lastNodeAdded = firstNode
        self.size = 1
        self.numWords = 1
        self.values = [firstNode.value : [firstNode : .zero]]
        self.coordinateRange = .zero
        addFirstWord(word: Array(word[1..<word.count]), direction: direction)
    }

    @discardableResult func add(value: Character, direction: Direction, relativeTo currentNode: Node) -> Node {
        let coordinate: Coordinate
        switch direction {
            case .above:
                coordinate = currentNode.coord.above
            case .below:
                coordinate = currentNode.coord.below
            case .before:
                coordinate = currentNode.coord.before
            case .after:
                coordinate = currentNode.coord.after
        }

        let newNode = Node(value: value, coord: coordinate)
        currentNode.connections[direction] = newNode
        newNode.connections[direction.opposite] = currentNode
        coordinateRange.expandIfOutside(coord: coordinate)
        if values[newNode.value] != nil {
            values[newNode.value]?[newNode] = coordinate
        } else {
            values[newNode.value] = .init(dictionaryLiteral: (newNode, coordinate))
        }
        lastNodeAdded = newNode
        size += 1
        return newNode
    }

    func addFirstWord(word: [Character], direction: Direction) {
        for char in word {
            let newNode = add(value: char, direction: direction, relativeTo: lastNodeAdded)
//            lastNodeAdded = newNode
            if values[newNode.value] != nil {
                values[newNode.value]?[newNode] = newNode.coord
            } else {
                values[newNode.value] = .init(dictionaryLiteral: (newNode, newNode.coord))
            }
            coordinateRange.expandIfOutside(coord: newNode.coord)
        }
    }

    func addWordIfFits(word: [Character]) -> Bool {
        for char in 0..<word.count {
            guard let possibleIntersectionPoints = values[word[char]] else { return false }
            for (node, coord) in possibleIntersectionPoints {
                let axis = node.checkConnections()
                if testWordFits(word: word, baseCoord: coord, axis: axis, charIndex: char) == true {
                    lastNodeAdded = node
                    for i in 0..<char {
                        let direction: Direction = axis == .horizontal ? .before : .above
                        if direction == .before, getValue(coordinate: Coordinate(x: lastNodeAdded.coord.x - 1, y: lastNodeAdded.coord.y)) != "0" {
                            continue
                        } else if direction == .above, getValue(coordinate: Coordinate(x: lastNodeAdded.coord.x, y: lastNodeAdded.coord.y + 1)) != "0" {
                            continue
                        } else {
                            let newNode = add(value: word[char - i], direction: direction, relativeTo: lastNodeAdded)
                            lastNodeAdded = newNode
                            coordinateRange.expandIfOutside(coord: newNode.coord)
                            continue
                        }
                    }
                    if char != word.count - 1 {
                        for i in (char + 1)..<word.count {
                            let direction: Direction = axis == .horizontal ? .after : .below
                            if direction == .after, getValue(coordinate: Coordinate(x: lastNodeAdded.coord.x + 1, y: lastNodeAdded.coord.y)) != "0" {
                                continue
                            } else if direction == .below, getValue(coordinate: Coordinate(x: lastNodeAdded.coord.x, y: lastNodeAdded.coord.y - 1)) != "0" {
                                continue
                            }
                            let newNode = add(value: word[i], direction: direction, relativeTo: lastNodeAdded)
                            lastNodeAdded = newNode
                            values[newNode.value]?[newNode] = newNode.coord
                            coordinateRange.expandIfOutside(coord: newNode.coord)
                            
                        }
                    }
                    numWords += 1
                    return true
                }
            }
        }
        return false
    }

    func getValue(coordinate: Coordinate) -> Character {
        for (char, value) in values {
            for (_, coord) in value where coord == coordinate {
                return char
            }
        }
        return "0"
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
