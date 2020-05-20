//
//  CharacterSet+Sequence.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/20/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

extension CharacterSet: Sequence, IteratorProtocol {
    var count: Int {
        return self.underestimatedCount
    }

    public mutating func next() -> Unicode.Scalar? {
        if count > self.count { // Not sure this is quite right
            return nil
        } else {
            defer {
                // Something goes here
            }
            return nil // Needs to return character rather than nil
        }
    }

}
