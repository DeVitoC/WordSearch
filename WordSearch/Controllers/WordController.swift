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
    var defaults = UserDefaults.standard
    let languages = ["English" : "en", "Spanish" : "es", "German" : "de", "Italian" : "it", "French" : "fr", "Dutch" : "nl", "Danish" : "da"]
    lazy var ctryCode: String = {
        let ctryCode: String
        if let language = defaults.string(forKey: DefaultKeys.language.rawValue), let countryCode = languages[language] {
            ctryCode = countryCode
        } else {
            ctryCode = "en"
        }

        return ctryCode
    }()
    
    // MARK: - CRUD Methods
    func createWord(maxSize: Int) -> Word {
        let mainWord: String
//        let ctryCode: String
//        if let language = defaults.string(forKey: DefaultKeys.language.rawValue), let countryCode = languages[language] {
//            ctryCode = countryCode
//        }
        switch maxSize {
            case 4:
                let randomWord = generateWordsArray(fromFile: "Four", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 5:
                let randomWord = generateWordsArray(fromFile: "Five", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 6:
                let randomWord = generateWordsArray(fromFile: "Six", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 7:
                let randomWord = generateWordsArray(fromFile: "Seven", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 8:
                let randomWord = generateWordsArray(fromFile: "Eight", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 9:
                let randomWord = generateWordsArray(fromFile: "Nine", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 10:
                let randomWord = generateWordsArray(fromFile: "Ten", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 11:
                let randomWord = generateWordsArray(fromFile: "Eleven", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 12:
                let randomWord = generateWordsArray(fromFile: "Twelve", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 13:
                let randomWord = generateWordsArray(fromFile: "Thirteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 14:
                let randomWord = generateWordsArray(fromFile: "Fourteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 15:
                let randomWord = generateWordsArray(fromFile: "Fifteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 16:
                let randomWord = generateWordsArray(fromFile: "Sixteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 17:
                let randomWord = generateWordsArray(fromFile: "Seventeen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            case 18:
                let randomWord = generateWordsArray(fromFile: "Eighteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
            default:
                let randomWord = generateWordsArray(fromFile: "GreaterThanEighteen", forLanguage: ctryCode).randomElement()
                mainWord = randomWord != nil ? randomWord! : " "
        }
        let anagramWords = anagrams(maxSize: maxSize, mainWord: mainWord)
        let searchWordsArray: [String] = []
        let bonusWordsArray = anagramWords
        let newWord = Word(mainWord: mainWord,
                           anagrams: anagramWords,
                           searchWords: searchWordsArray,
                           bonusWords: bonusWordsArray)
        print("mainword: \(newWord.mainWord), searchwords: \(newWord.searchWords.count), bonuswords: \(newWord.bonusWords.count)")
        return newWord
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
            let threeLetterWords = generateWordsArray(fromFile: "Three", forLanguage: ctryCode)
            for word in threeLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 4 {
            let fourLetterWords = generateWordsArray(fromFile: "Four", forLanguage: ctryCode)
            for word in fourLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 5 {
            let fiveLetterWords = generateWordsArray(fromFile: "Five", forLanguage: ctryCode)
            for word in fiveLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 6 {
            let sixLetterWords = generateWordsArray(fromFile: "Six", forLanguage: ctryCode)
            for word in sixLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 7 {
            let sevenLetterWords = generateWordsArray(fromFile: "Seven", forLanguage: ctryCode)
            for word in sevenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 8 {
            let eightLetterWords = generateWordsArray(fromFile: "Eight", forLanguage: ctryCode)
            for word in eightLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 9 {
            let nineLetterWords = generateWordsArray(fromFile: "Nine", forLanguage: ctryCode)
            for word in nineLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 10 {
            let tenLetterWords = generateWordsArray(fromFile: "Ten", forLanguage: ctryCode)
            for word in tenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 11 {
            let elevenLetterWords = generateWordsArray(fromFile: "Eleven", forLanguage: ctryCode)
            for word in elevenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 12 {
            let twelveLetterWords = generateWordsArray(fromFile: "Twelve", forLanguage: ctryCode)
            for word in twelveLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 13 {
            let thirteenLetterWords = generateWordsArray(fromFile: "Thirteen", forLanguage: ctryCode)
            for word in thirteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 14 {
            let fourteenLetterWords = generateWordsArray(fromFile: "Fourteen", forLanguage: ctryCode)
            for word in fourteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 15 {
            let fifteenLetterWords = generateWordsArray(fromFile: "Fifteen", forLanguage: ctryCode)
            for word in fifteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 16 {
            let sixteenLetterWords = generateWordsArray(fromFile: "Sixteen", forLanguage: ctryCode)
            for word in sixteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 17 {
            let seventeenLetterWords = generateWordsArray(fromFile: "Seventeen", forLanguage: ctryCode)
            for word in seventeenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 18 {
            let eighteenLetterWords = generateWordsArray(fromFile: "Eighteen", forLanguage: ctryCode)
            for word in eighteenLetterWords where CharacterSet(charactersIn: word).isSubset(of: charSet) {
                guard let testWord = testAnagramWord(word: word, letterDict: letterDict) else { continue }
                anagrams.append(testWord)
            }
        }
        if maxSize >= 19 {
            let greaterThanEighteenLetterWords = generateWordsArray(fromFile: "GreaterThanEighteen", forLanguage: ctryCode)
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

    private func generateWordsArray(fromFile file: String, forLanguage language: String) -> [String] {
        // temporary variables and filePath setup
        var wordsArray: [String] = []
        let jsonDecoder = JSONDecoder()
        var decodedDictionary: [String : Int] = [ : ]
        let file = "/\(language)\(file)LetterWords.json"
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
