//
//  Word.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/10/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

/// A model for all the words used in a  game
class Word: Codable {
    //var theme: String // TODO: - implement themes
    var mainWord: String
    var anagrams: [String]
    var searchWords: [String]
    var bonusWords: [String]

    internal init(mainWord: String, anagrams: [String], searchWords: [String], bonusWords: [String]) {
        self.mainWord = mainWord
        self.anagrams = anagrams
        self.searchWords = searchWords
        self.bonusWords = bonusWords
    }
}
