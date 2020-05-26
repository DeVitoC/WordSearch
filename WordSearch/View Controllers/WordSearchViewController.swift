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
    let gameBoardController = GameBoardController()
    private var word: Word?
    private lazy var letterButtons: [UIButton] = [letter1Button, letter2Button, letter3Button, letter4Button, letter5Button, letter6Button]
    private var wordInProgress: String = ""
    private var wordMapLabels: [[UILabel]] = []
    private var gameBoard: GameBoard? {
        didSet {
            word = gameBoard?.word
        }
    }
    private var wordMap: [[Character?]] = [] {
        didSet {
            updateViews()
        }
    }
    var stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    // MARK: - IBOutlets
    @IBOutlet weak var letter1Button: UIButton!
    @IBOutlet weak var letter2Button: UIButton!
    @IBOutlet weak var letter3Button: UIButton!
    @IBOutlet weak var letter4Button: UIButton!
    @IBOutlet weak var letter5Button: UIButton!
    @IBOutlet weak var letter6Button: UIButton!
    @IBOutlet weak var checkWordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        gameBoard = gameBoardController.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            wordMap = gameBoardController.generateWordMap(gameBoard: gameBoard)
        }
    }

    private func updateViews() {
        guard let word = word else { return }
        generateGameBoardMap()
        let mainWordChars: [Character] = Array(word.mainWord)
        print("\(mainWordChars)")
        letter1Button.setTitle("\(mainWordChars[0].uppercased())", for: .normal)
        letter2Button.setTitle("\(mainWordChars[1].uppercased())", for: .normal)
        letter3Button.setTitle("\(mainWordChars[2].uppercased())", for: .normal)
        letter4Button.setTitle("\(mainWordChars[3].uppercased())", for: .normal)
        letter5Button.setTitle("\(mainWordChars[4].uppercased())", for: .normal)
        letter6Button.setTitle("\(mainWordChars[5].uppercased())", for: .normal)


    }

    /// Generates a grid of UILabels inside stacked UIStackViews for a map of 2 times the length of the primary word plus 1
    private func generateGameBoardMap() {
        guard let word = word else { return }

        // Set up main UIStackView - "stackView"
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])

        // Add stacks of UIStackViews - "stackView.arrangedSubViews[] as UIStackView"
        for _ in 0...word.mainWord.count * 2 {
            let subStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 25))
            stackView.addArrangedSubview(subStack)
            subStack.axis = .horizontal
            subStack.distribution = .fillEqually
            subStack.alignment = .fill
        }

        // Add row of twice the main word's length plus 1 labels in sub-stackviews -
        // "(stackView.arrangedSubViews[] as UIStackView).arrangedSubViews[] as UIStackView"
        for y in 0...word.mainWord.count * 2 {
            for _ in 0...word.mainWord.count * 2 {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
                label.text = "-"
                (stackView.arrangedSubviews[y] as! UIStackView).addArrangedSubview(label)
            }
        }
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
        guard let word = word else { return }
        if word.searchWords.contains(wordInProgress.lowercased()) {
            print("Success: \(wordInProgress) is in search words")
        } else if word.bonusWords.contains(wordInProgress.lowercased()) {
            print("Success: \(wordInProgress) is in bonus words")
        } else {
            print("Try again: \(wordInProgress) is not a word")
        }
        resetWord(self)
    }

    @IBAction func resetWord(_ sender: Any) {
        wordInProgress = ""
        for button in letterButtons {
            button.isSelected = false
        }
    }

}
