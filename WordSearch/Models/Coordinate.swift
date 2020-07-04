//
//  Coordinate.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

struct Coordinate {
    var x: Int
    var y: Int
    static let zero = Coordinate(x: 0, y: 0)

    var above: Coordinate {
        .init(x: x, y: y + 1)
    }

    var below: Coordinate {
        .init(x: x, y: y - 1)
    }

    var before: Coordinate {
        .init(x: x - 1, y: y)
    }

    var after: Coordinate {
        .init(x: x + 1, y: y)
    }

    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        let sameX = lhs.x == rhs.x
        let sameY = lhs.y == rhs.y
        return sameX && sameY
    }
}
