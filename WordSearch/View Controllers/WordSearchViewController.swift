//
//  WordSearchViewController.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class WordSearchViewController: UIViewController {
    
    // MARK: - Properties
    let wordController = WordController()
    private var word: Word?
    private lazy var letterButtons: [UIButton] = [letter1Button, letter2Button, letter3Button, letter4Button, letter5Button, letter6Button]
    private var wordInProgress: String = ""
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchWordsTextView: UITextView!
    @IBOutlet weak var bonusWordsTextView: UITextView!
    @IBOutlet weak var letter1Button: UIButton!
    @IBOutlet weak var letter2Button: UIButton!
    @IBOutlet weak var letter3Button: UIButton!
    @IBOutlet weak var letter4Button: UIButton!
    @IBOutlet weak var letter5Button: UIButton!
    @IBOutlet weak var letter6Button: UIButton!
    @IBOutlet weak var checkWordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        word = wordController.createWord(maxSize: 6)
        updateViews()
    }

    private func updateViews() {
        guard let word = word else { return }
        let mainWordChars = Array(word.mainWord)
        searchWordsTextView.text = word.searchWords.joined(separator: "\n")
        bonusWordsTextView.text = word.bonusWords.joined(separator: "\n")
        print("\(mainWordChars)")
        letter1Button.setTitle("\(mainWordChars[0].uppercased())", for: .normal)
        letter2Button.setTitle("\(mainWordChars[1].uppercased())", for: .normal)
        letter3Button.setTitle("\(mainWordChars[2].uppercased())", for: .normal)
        letter4Button.setTitle("\(mainWordChars[3].uppercased())", for: .normal)
        letter5Button.setTitle("\(mainWordChars[4].uppercased())", for: .normal)
        letter6Button.setTitle("\(mainWordChars[5].uppercased())", for: .normal)
    }

    // MARK: - IBActions
    @IBAction func letter1Tapped(_ sender: Any) {
        if letter1Button.isSelected {
            letter1Button.isSelected = false
        } else {
            letter1Button.isSelected = true
            guard let letter = letter1Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func letter2Tapped(_ sender: Any) {
        if letter2Button.isSelected {
            letter2Button.isSelected = false
        } else {
            letter2Button.isSelected = true
            guard let letter = letter2Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func letter3Tapped(_ sender: Any) {
        if letter3Button.isSelected {
            letter3Button.isSelected = false
        } else {
            letter3Button.isSelected = true
            guard let letter = letter3Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func letter4Tapped(_ sender: Any) {
        if letter4Button.isSelected {
            letter4Button.isSelected = false
        } else {
            letter4Button.isSelected = true
            guard let letter = letter4Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func letter5Tapped(_ sender: Any) {
        if letter5Button.isSelected {
            letter5Button.isSelected = false
        } else {
            letter5Button.isSelected = true
            guard let letter = letter5Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func letter6Tapped(_ sender: Any) {
        if letter6Button.isSelected {
            letter6Button.isSelected = false
        } else {
            letter6Button.isSelected = true
            guard let letter = letter6Button.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }
    @IBAction func checkWord(_ sender: Any) {
    }
    
}
