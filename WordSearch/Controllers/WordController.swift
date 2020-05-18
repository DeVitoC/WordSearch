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
    lazy private var words: [String] = {
        generateWordsArray(fromFile: "all")
    }()

    lazy private var threeLetterWords: [String] = {
        generateWordsArray(fromFile: "three")
    }()

    lazy private var fourLetterWords: [String] = {
        generateWordsArray(fromFile: "four")
    }()

    lazy private var fiveLetterWords: [String] = {
        generateWordsArray(fromFile: "five")
        //convert from words array to specific length words array.
//        var fiveDict: [String : Int] = [:]
//        for word in words where word.count > 22 {
//            fiveDict[word] = 1
//        }
//        for entry in fiveDict {
//            print("\"\(entry.key)\": \(entry.value),")
//        }
    }()

    lazy private var sixLetterWords: [String] = {
        generateWordsArray(fromFile: "six")
    }()

    lazy private var sevenLetterWords: [String] = {
        generateWordsArray(fromFile: "seven")
    }()

    lazy private var eightLetterWords: [String] = {
        generateWordsArray(fromFile: "eight")
    }()

    lazy private var nineLetterWords: [String] = {
        generateWordsArray(fromFile: "nine")
    }()
    
    lazy private var tenLetterWords: [String] = {
        generateWordsArray(fromFile: "ten")
    }()
    
    lazy private var elevenLetterWords: [String] = {
        generateWordsArray(fromFile: "eleven")
    }()
    
    lazy private var twelveLetterWords: [String] = {
        generateWordsArray(fromFile: "twelve")
    }()
    
    lazy private var thirteenLetterWords: [String] = {
        generateWordsArray(fromFile: "thirteen")
    }()
    
    lazy private var fourteenLetterWords: [String] = {
        generateWordsArray(fromFile: "fourteen")
    }()
    
    lazy private var fifteenLetterWords: [String] = {
        generateWordsArray(fromFile: "fifteen")
    }()
    
    lazy private var sixteenLetterWords: [String] = {
        generateWordsArray(fromFile: "sixteen")
    }()
    
    lazy private var seventeenLetterWords: [String] = {
        generateWordsArray(fromFile: "seventeen")
    }()
    
    lazy private var eighteenLetterWords: [String] = {
        generateWordsArray(fromFile: "eighteen")
    }()
    
    lazy private var nineteenLetterWords: [String] = {
        generateWordsArray(fromFile: "nineteen")
    }()
    
    lazy private var twentyLetterWords: [String] = {
        generateWordsArray(fromFile: "twenty")
    }()
    
    lazy private var twentyOneLetterWords: [String] = {
        generateWordsArray(fromFile: "twentyOne")
    }()
    
    lazy private var twentyTwoLetterWords: [String] = {
        generateWordsArray(fromFile: "twentyTwo")
    }()
    
    lazy private var greaterThanTwentyTwoLetterWords: [String] = {
        generateWordsArray(fromFile: "greaterThanTwentyTwo")
    }()

    // MARK: - Other Properties
    var gameWords: [Word] = []
    
    // MARK: - CRUD Methods
    func createWord(maxSize: Int) -> Word {
        //let mainWord = sixLetterWords.randomElement()
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
    
    // MARK: - Helper Methods
    
    private func anagrams(maxSize: Int, mainWord: String) -> [String] {
        // TODO: - Fix issue where method returns words with more letters than original
        // for instance: "pashas" anagrams includes "aaa"
        var anagrams: [String] = []
        let charSet = CharacterSet(charactersIn: mainWord)
        var letterDict: [Character : Int] = [:]
        for letter in mainWord {
            letterDict[letter] = letterDict.keys.contains(letter) ? (letterDict[letter]! + 1) : 1
        }

        if maxSize > 3 {
            for word in threeLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                var threeDict: [Character : Int] = [:]
                for letter in word {
                    threeDict[letter] = threeDict.keys.contains(letter) ? (threeDict[letter]! + 1) : 1
                    guard let three = threeDict[letter], let main = letterDict[letter] else { break }
                    //(three > main) ? return : continue

                }
                anagrams.append(word)
            }
        }
        if maxSize > 4 {
            for word in fourLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 5 {
            for word in fiveLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 6 {
            for word in sixLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 7 {
            for word in sevenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 8 {
            for word in eightLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 9 {
            for word in nineLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 10 {
            for word in tenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 11 {
            for word in elevenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 12 {
            for word in twelveLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 13 {
            for word in thirteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 14 {
            for word in fourteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 15 {
            for word in fifteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 16 {
            for word in sixteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 17 {
            for word in seventeenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 18 {
            for word in eighteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 19 {
            for word in nineteenLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 20 {
            for word in twentyLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 21 {
            for word in twentyOneLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        if maxSize > 22 {
            for word in twentyTwoLetterWords {
                let wordSet = CharacterSet(charactersIn: word)
                if wordSet.isSubset(of: charSet) {
                    anagrams.append(word)
                }
            }
        }
        return anagrams
    }
    
    private func searchWords(anagrams: [String]) -> [String] {
    var searchwords: [String] = []
    var randomNumber: Int
    var anagrams = anagrams
    if anagrams.count > 10 {
        let highNumber = anagrams.count < 15 ? anagrams.count : 14
        randomNumber = Int.random(in: 8...highNumber)
    } else {
        randomNumber = anagrams.count - 1
    }
    for _ in 0...randomNumber {
        let rand = Int.random(in: 1...(anagrams.count))
        searchwords.append(anagrams[rand - 1])
        anagrams.remove(at: rand - 1)
    }
    return searchwords
}
    
    private func bonusWords(searchWords: [String], anagrams: [String]) -> [String] {
        var bonusWords: [String] = anagrams
        for word in searchWords {
            guard let index = bonusWords.firstIndex(of: word) else { continue }
            bonusWords.remove(at: index)
        }
        return bonusWords
    }
    
    private func generateWordsArray(fromFile file: String) -> [String] {
        // temporary variables and filePath setup
        var wordsArray: [String] = []
        let jsonDecoder = JSONDecoder()
        var decodedDictionary: [String : Int] = [ : ]
        let file = "/\(file)LetterWords.json"
        let bundle = Bundle.main.bundlePath
        let path = bundle.appending(file)
        
        // get JSON data and decode it
        guard let jsonData = NSData(contentsOfFile: path) else { return [""] }
        do {
            let data = Data(jsonData)
            decodedDictionary = try jsonDecoder.decode([String : Int].self, from: data)
        } catch {
            NSLog("\(error)")
        }

        // convert from decoded dictionary to array
        for (key, _) in decodedDictionary {
            wordsArray.append(key)
        }
        
        return wordsArray
    }
}
