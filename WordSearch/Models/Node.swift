//
//  Node.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class Node: Hashable, CustomStringConvertible, NSCopying {
    var value: Character
    var connections: [Direction : Node] = [ : ]
    let coord: Coordinate

    init(value: Character = "0", coord: Coordinate) {
        self.value = value
        self.coord = coord
    }

    var description: String {
        var description = ""
        description += "Value: \(value)\n"
        description += "Coordinate: \(coord)\n"
        for connection in connections {
            description += "Connection: \(connection.key), Value: \(connection.value.value)\n"
        }
        return description
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        let sameX = lhs.coord.x == rhs.coord.x
        let sameY = lhs.coord.y == rhs.coord.y
        return sameX && sameY
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Node(value: value, coord: coord)
        copy.connections = connections
        return copy
    }

    func checkConnections() -> Axis {
        let canBeHorizontal = (connections[.before] == nil && connections[.after] == nil) ? true : false
        let canBeVertical = (connections[.above] == nil && connections[.below] == nil) ? true : false
        if canBeHorizontal {
            return .horizontal
        } else if canBeVertical {
            return .vertical
        } else {
            return .notAvailable
        }
    }
}
