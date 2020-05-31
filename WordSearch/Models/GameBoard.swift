//
//  GameBoard.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

/// GameBoard model with all the data for play and display for a level
class GameBoard {
    var word: Word
    var foundWords: [String]
    var remainingWords: [String]

    init(word: Word) {
        self.word = word
        self.foundWords = []
        self.remainingWords = word.anagrams
    }
}
