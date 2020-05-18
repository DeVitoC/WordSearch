//
//  WordController.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/10/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class WordController {
    
    // MARK: - Computed Properties
    lazy var words: [String] = {
        var temp: [String] = []
        let file = "/words_dictionary.json"
        let bundle = Bundle.main.bundlePath
        let path = bundle.appending(file)
        var jsonData = NSData(contentsOfFile: path)
        
        guard let jsonData2 = jsonData else { return [""]}
        let data = Data(jsonData2)
        let jsonDecoder = JSONDecoder()
        var decodedObject: [String : Int] = [ : ]
        do {
            decodedObject = try jsonDecoder.decode([String : Int].self, from: data)
        } catch {
            NSLog("\(error)")
        }
        
        for (key, value) in decodedObject {
            temp.append(key)
        }
        return temp
    }()
    //private let threeLetterWords
    
    //private let fourLetterWords
    
    lazy var fiveLetterWords: [String] = {
        var fiveLetters: [String] = []
        var fiveDict: [String : Int] = [ : ]
        for word in words where word.count == 5 {
            fiveDict[word] = 1
        }
        print("\(fiveDict)")
        return fiveLetters
    }()
    
    lazy var sixLetterWords: [String] = {
        var sixLetters: [String] = []
        for word in words where word.count == 6 {
            sixLetters.append(word)
        }
        return sixLetters
    }()
    
    var gameWords: [Word] = []
    
    func createWord(maxSize: Int) -> Word {
        let randomNumber = Int.random(in: 0..<(sixLetterWords.count))
        let anagramWords = anagrams(maxSize: maxSize, mainWord: sixLetterWords[randomNumber])
        let searchWordsArray = searchWords(anagrams: anagramWords)
        let bonusWordsArray = bonusWords(searchWords: searchWordsArray, anagrams: anagramWords)
        let newWord = Word(mainWord: sixLetterWords[randomNumber],
                           anagrams: anagramWords,
                           searchWords: searchWordsArray,
                           bonusWords: bonusWordsArray)
        gameWords.append(newWord)
        return newWord
    }
    
    func anagrams(maxSize: Int, mainWord: String) -> [String] {
        var anagrams: [String] = []
//        if maxSize > 3 {
//            for word in threeLetterWords where mainWord.contains(word) {
//                anagrams.append(word)
//            }
//        }
//        if maxSize > 4 {
//            for word in fourLetterWords where mainWord.contains(word) {
//                anagrams.append(word)
//            }
//        }
        if maxSize > 5 {
            for word in fiveLetterWords where mainWord.contains(word) {
                anagrams.append(word)
            }
        }
        if maxSize > 6 {
            for word in sixLetterWords where mainWord.contains(word) {
                anagrams.append(word)
            }
        }
        return anagrams
    }
    
    func searchWords(anagrams: [String]) -> [String] {
        var searchwords: [String] = []
        var randomNumber: Int
        var anagrams = anagrams
        if anagrams.count > 10 {
            randomNumber = Int.random(in: 6...11)
        } else {
            randomNumber = anagrams.count - 1
        }
        for _ in 0...randomNumber {
            let rand = Int.random(in: 0...(anagrams.count))
            searchwords.append(anagrams[rand])
            anagrams.remove(at: rand)
        }
        return searchwords
    }
    
    func bonusWords(searchWords: [String], anagrams: [String]) -> [String] {
        var bonusWords: [String] = anagrams
        for word in searchWords {
            guard let index = searchWords.firstIndex(of: word) else { continue }
            bonusWords.remove(at: index)
        }
        return bonusWords
    }
}
