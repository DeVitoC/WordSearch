//
//  WordController.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/10/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class WordController {

    // MARK: - Properties
    //var gameWords: [Word] = []
    var word: Word?
    
    // MARK: - CRUD Methods
    func createWord(maxSize: Int) -> Word {
        let mainWord: String
        switch maxSize {
            case 4:
                let randomWord = generateWordsArray(fromFile: "four").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 5:
                let randomWord = generateWordsArray(fromFile: "five").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 6:
                let randomWord = generateWordsArray(fromFile: "six").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 7:
                let randomWord = generateWordsArray(fromFile: "seven").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 8:
                let randomWord = generateWordsArray(fromFile: "eight").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 9:
                let randomWord = generateWordsArray(fromFile: "nine").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 10:
                let randomWord = generateWordsArray(fromFile: "ten").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 11:
                let randomWord = generateWordsArray(fromFile: "eleven").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 12:
                let randomWord = generateWordsArray(fromFile: "twelve").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 13:
                let randomWord = generateWordsArray(fromFile: "thirteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 14:
                let randomWord = generateWordsArray(fromFile: "fourteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 15:
                let randomWord = generateWordsArray(fromFile: "fifteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 16:
                let randomWord = generateWordsArray(fromFile: "sixteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 17:
                let randomWord = generateWordsArray(fromFile: "seventeen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 18:
                let randomWord = generateWordsArray(fromFile: "eighteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            default:
                let randomWord = generateWordsArray(fromFile: "greaterThanEighteen").randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
        }
        let anagramWords = anagrams(maxSize: maxSize, mainWord: mainWord)
        //let searchWordsArray = searchWords(anagrams: anagramWords)
        let searchWordsArray: [String] = []
        let bonusWordsArray = anagramWords
        //let bonusWordsArray = bonusWords(searchWords: searchWordsArray, anagrams: anagramWords)
        let newWord = Word(mainWord: mainWord,
                           anagrams: anagramWords,
                           searchWords: searchWordsArray,
                           bonusWords: bonusWordsArray)
        //gameWords.append(newWord)
        word = newWord
        print("mainword: \(newWord.mainWord), searchwords: \(newWord.searchWords.count), bonuswords: \(newWord.bonusWords.count)")
        return newWord
    }

    func addSearchWord(searchWord: String) {
        guard let index = word?.bonusWords.firstIndex(of: searchWord) else { return }
        if let isInSearchWords = word?.searchWords.contains(searchWord), !isInSearchWords {
            word?.searchWords.append(searchWord)
        }
        if let isInBonusWords = word?.bonusWords.contains(searchWord), isInBonusWords {
            word?.bonusWords.remove(at: index)
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func anagrams(maxSize: Int, mainWord: String) -> [String] {
        var letterDict: [Character : Int] = [:]
        for letter in mainWord {
            letterDict[letter] = letterDict.keys.contains(letter) ? (letterDict[letter]! + 1) : 1
        }
        var anagrams: [String] = []
        let charSet = CharacterSet(charactersIn: mainWord)
        if maxSize >= 3 {
            let threeLetterWords = generateWordsArray(fromFile: "three")
            for word in threeLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 4 {
            let fourLetterWords = generateWordsArray(fromFile: "four")
            for word in fourLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 5 {
            let fiveLetterWords = generateWordsArray(fromFile: "five")
            for word in fiveLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 6 {
            let sixLetterWords = generateWordsArray(fromFile: "six")
            for word in sixLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 7 {
            let sevenLetterWords = generateWordsArray(fromFile: "seven")
            for word in sevenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 8 {
            let eightLetterWords = generateWordsArray(fromFile: "eight")
            for word in eightLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 9 {
            let nineLetterWords = generateWordsArray(fromFile: "nine")
            for word in nineLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 10 {
            let tenLetterWords = generateWordsArray(fromFile: "ten")
            for word in tenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 11 {
            let elevenLetterWords = generateWordsArray(fromFile: "eleven")
            for word in elevenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 12 {
            let twelveLetterWords = generateWordsArray(fromFile: "twelve")
            for word in twelveLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 13 {
            let thirteenLetterWords = generateWordsArray(fromFile: "thirteen")
            for word in thirteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 14 {
            let fourteenLetterWords = generateWordsArray(fromFile: "fourteen")
            for word in fourteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 15 {
            let fifteenLetterWords = generateWordsArray(fromFile: "fifteen")
            for word in fifteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 16 {
            let sixteenLetterWords = generateWordsArray(fromFile: "sixteen")
            for word in sixteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 17 {
            let seventeenLetterWords = generateWordsArray(fromFile: "seventeen")
            for word in seventeenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 18 {
            let eighteenLetterWords = generateWordsArray(fromFile: "eighteen")
            for word in eighteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 19 {
            let greaterThanEighteenLetterWords = generateWordsArray(fromFile: "greaterThanEighteen")
            for word in greaterThanEighteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        return anagrams
    }

    private func testAnagramWord(word: String, letterDict: [Character : Int]) -> String? {
        var anagramWordDict: [Character : Int] = [:]
        for letter in word {
            anagramWordDict[letter] = anagramWordDict.keys.contains(letter) ? (anagramWordDict[letter]! + 1) : 1
            guard let anagramLetter = anagramWordDict[letter], let main = letterDict[letter] else { return nil }
            if anagramLetter > main {
                return nil
            }
        }
        return word
    }

    private func searchWords(anagrams: [String]) -> [String] {
        var searchwords: [String] = []
        var randomNumber: Int
        var anagrams = anagrams
        let highNumber = anagrams.count < 15 ? anagrams.count : 14
        randomNumber = anagrams.count > 10 ? Int.random(in: 8...highNumber) : anagrams.count - 1
        for _ in 0...randomNumber {
            if anagrams.count == 0 { break }
            let rand = Int.random(in: 1...(anagrams.count))
            searchwords.append(anagrams[rand - 1])
            anagrams.remove(at: rand - 1)
        }
        return searchwords
    }

//    private func bonusWords(searchWords: [String], anagrams: [String]) -> [String] {
//        var bonusWords: [String] = anagrams
//        for word in searchWords {
//            guard let index = bonusWords.firstIndex(of: word) else { continue }
//            bonusWords.remove(at: index)
//        }
//        return bonusWords
//    }

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
