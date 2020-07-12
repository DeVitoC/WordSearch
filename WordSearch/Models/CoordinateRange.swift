//
//  CoordinateRange.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

struct CoordinateRange {
    var high: Coordinate
    var low: Coordinate

    static let zero = CoordinateRange(high: .zero, low: .zero)

    mutating func expandIfOutside(coord: Coordinate) {
        high.x = max(coord.x, high.x)
        high.y = max(coord.y, high.y)
        low.x = min(coord.x, low.x)
        low.y = min(coord.y, low.y)
    }
}
