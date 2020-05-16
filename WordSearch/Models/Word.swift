//
//  Word.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/10/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

struct Word: Codable, Equatable {
    //var theme: String // TODO: - implement themes
    var mainWord: String
    var anagrams: [String]
    var searchWords: [String]
    var bonusWords: [String]
}
