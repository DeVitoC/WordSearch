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
        let words = wordController.greaterThanTwentyTwoLetterWords
        print(words.count)
        
    }

    // MARK: - IBActions
    @IBAction func letter1Tapped(_ sender: Any) {
    }
    @IBAction func letter2Tapped(_ sender: Any) {
    }
    @IBAction func letter3Tapped(_ sender: Any) {
    }
    @IBAction func letter4Tapped(_ sender: Any) {
    }
    @IBAction func letter5Tapped(_ sender: Any) {
    }
    @IBAction func letter6Tapped(_ sender: Any) {
    }
    @IBAction func checkWord(_ sender: Any) {
    }
    
}
