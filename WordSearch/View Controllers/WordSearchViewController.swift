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
    var gameBoardMapStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var buttonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    // MARK: - IBOutlets
    @IBOutlet weak var letter1Button: UIButton!
    @IBOutlet weak var letter2Button: UIButton!
    @IBOutlet weak var letter3Button: UIButton!
    @IBOutlet weak var letter4Button: UIButton!
    @IBOutlet weak var letter5Button: UIButton!
    @IBOutlet weak var letter6Button: UIButton!
    @IBOutlet weak var checkWordButton: UIButton!
    @IBOutlet var buttons: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons.isHidden = true
        gameBoard = gameBoardController.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            wordMap = gameBoardController.generateWordMap(gameBoard: gameBoard)
        }
    }

    private func updateViews() {
        guard let word = word else { return }
        generateGameBoardMap()
        generateButtons()
        let mainWordChars: [Character] = Array(word.mainWord)
        print("\(mainWordChars)")
        letter1Button.setTitle("\(mainWordChars[0].uppercased())", for: .normal)
        letter2Button.setTitle("\(mainWordChars[1].uppercased())", for: .normal)
        letter3Button.setTitle("\(mainWordChars[2].uppercased())", for: .normal)
        letter4Button.setTitle("\(mainWordChars[3].uppercased())", for: .normal)
        letter5Button.setTitle("\(mainWordChars[4].uppercased())", for: .normal)
        letter6Button.setTitle("\(mainWordChars[5].uppercased())", for: .normal)


    }

    // MARK: - Set Up Methods
    /// Generates a grid of UILabels inside stacked UIStackViews for a map of 2 times the length of the primary word plus 1
    private func generateGameBoardMap() {
        guard let word = word else { return }

        // Set up main UIStackView - "gameBoardMapStackView"
        self.view.addSubview(gameBoardMapStackView)
        gameBoardMapStackView.translatesAutoresizingMaskIntoConstraints = false
        gameBoardMapStackView.axis = .vertical
        gameBoardMapStackView.distribution = .fillEqually
        gameBoardMapStackView.alignment = .fill
        NSLayoutConstraint.activate([
            gameBoardMapStackView.topAnchor.constraint(equalTo: view.topAnchor),
            gameBoardMapStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameBoardMapStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameBoardMapStackView.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])

        // Add stacks of UIStackViews - "gameBoardMapStackView.arrangedSubViews[] as UIStackView"
        for _ in 0...word.mainWord.count * 2 {
            let subStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 25))
            gameBoardMapStackView.addArrangedSubview(subStack)
            subStack.axis = .horizontal
            subStack.distribution = .fillEqually
            subStack.alignment = .fill
        }

        // Add row of twice the main word's length plus 1 labels in sub-stackviews -
        // "(gameBoardMapStackView.arrangedSubViews[] as UIStackView).arrangedSubViews[] as UIStackView"
        for y in 0...word.mainWord.count * 2 {
            for _ in 0...word.mainWord.count * 2 {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
                label.text = "-"
                (gameBoardMapStackView.arrangedSubviews[y] as! UIStackView).addArrangedSubview(label)
            }
        }
    }

    /// Generates a row of UIButtons to display the characters in use for game play
    private func generateButtons() {
        guard let word = word else { return }
        let mainWord: [Character] = Array(word.mainWord)

        // Sets up button UIStackView
        self.view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.alignment = .fill
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])

        // Generates a button for each character in the main word
        for char in 0..<mainWord.count {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .systemRed
            button.setTitleColor(.black, for: .normal)
            button.setTitle("\(mainWord[char].uppercased())", for: .normal)
            button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
            buttonsStackView.addArrangedSubview(button)
        }
    }

    // MARK: - Action Methods
    @objc func letterButtonTapped(_ sender: UIButton) {
        guard let character = sender.titleLabel?.text else { return }
        print(character)
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            guard let letter = sender.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
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
