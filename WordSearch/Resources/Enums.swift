//
//  Enums.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

enum Direction: Hashable {
    case above
    case below
    case before
    case after

    var opposite: Direction {
        switch self {
            case .above:
                return .below
            case .below:
                return .above
            case .before:
                return .after
            case .after:
                return .before
        }
    }
}

enum Axis: Hashable {
    case horizontal
    case vertical
    case notAvailable
}
