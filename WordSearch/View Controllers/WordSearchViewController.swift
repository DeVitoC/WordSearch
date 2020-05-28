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
    let gameBoardController = GameBoardController()
    private var word: Word?
    lazy var mainWord: [Character] = {
        guard let word = word else { return [] }
        return Array(word.mainWord)
    }()
    private lazy var letterButtons: [UIButton] = []
    private var wordInProgress: String = ""
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
    lazy var gameBoardMapStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsCollectionView = UICollectionView(frame: CGRect(center: .zero, size: CGSize(width: view.frame.width * 0.6, height: view.frame.width * 0.6)), collectionViewLayout: LetterButtonsLayout())
    lazy var activeAreaStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.delegate = self
        gameBoard = gameBoardController.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            wordMap = gameBoardController.generateWordMap(gameBoard: gameBoard)
        }
    }

    private func updateViews() {
        generateGameBoardMap()
        generateActivePlayButtons()
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
            gameBoardMapStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            gameBoardMapStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameBoardMapStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
        populateGameBoardMap()
    }

    /// Populates Game Board Map with values from wordMap
    private func populateGameBoardMap() {
        for y in 0..<gameBoardMapStackView.arrangedSubviews.count {
            guard let stack = gameBoardMapStackView.arrangedSubviews[y] as? UIStackView else { continue }
            for x in 0..<stack.arrangedSubviews.count {
                guard let label = stack.arrangedSubviews[x] as? UILabel else { continue }
                let char: String = String(wordMap[y][x] ?? " ")
                label.text = char
            }
        }
    }

    /// Generates the Active Play area with the letter, reset, and check word UIButtons
    private func generateActivePlayButtons() {
        // Create activeAreaStackView with constraints
        self.view.addSubview(activeAreaStackView)
        activeAreaStackView.translatesAutoresizingMaskIntoConstraints = false
        activeAreaStackView.axis = .vertical
        activeAreaStackView.alignment = .fill
        activeAreaStackView.distribution = .fillEqually
        activeAreaStackView.spacing = 10
        NSLayoutConstraint.activate([
            activeAreaStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            activeAreaStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activeAreaStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activeAreaStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])

        // create and add letter buttons to Active Play area UIStackView
        generateButtons()
        //activeAreaStackView.addArrangedSubview(buttonsCollectionView)

        // create and add UIStackView for reset and check word UIButtons
        let controlButtonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controlButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlButtonsStackView.axis = .horizontal
        controlButtonsStackView.alignment = .center
        controlButtonsStackView.distribution = .fillEqually
        controlButtonsStackView.spacing = 10
        activeAreaStackView.addArrangedSubview(controlButtonsStackView)

        // add reset and check word UIButtons to controlButtonsStackView
        controlButtonsStackView.addArrangedSubview(generateResetButton())
        controlButtonsStackView.addArrangedSubview(generateCheckWordButton())

    }

    /// Generates a circle CollectionView of UIButtons to display the characters in use for game play
    private func generateButtons() {
        self.view.addSubview(buttonsCollectionView)
        buttonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        buttonsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "LetterCell")
        buttonsCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            buttonsCollectionView.topAnchor.constraint(equalTo: gameBoardMapStackView.bottomAnchor, constant: 0),
            buttonsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            buttonsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    /// Generates a reset UIButton to set the in progress word to an emptry string
    private func generateResetButton() -> UIButton {
        let resetButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.backgroundColor = .systemBlue
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.setTitle("Reset Word", for: .normal)
        resetButton.addTarget(self, action: #selector(resetWord(_:)), for: .touchUpInside)
        return resetButton
    }

    /// Generates a check word UIButton to check the word against the list of acceptable words
    private func generateCheckWordButton() -> UIButton {
        let checkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.backgroundColor = .systemTeal
        checkButton.setTitleColor(.black, for: .normal)
        checkButton.setTitle("Check Word", for: .normal)
        checkButton.addTarget(self, action: #selector(checkWord(_:)), for: .touchUpInside)
        return checkButton
    }

    // MARK: - Action Methods
    /// Defines the action taken when a letter button is tapped
    @objc func letterButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            guard let letter = sender.titleLabel?.text else { return }
            wordInProgress.append(letter)
            print(wordInProgress)
        }
    }

    /// Defines the action taken when the reset button is tapped
    @objc func resetWord(_ sender: UIButton) {
        wordInProgress = ""
        for button in letterButtons {
            button.isSelected = false
        }
    }

    /// Defines the action taken when the check word button is tapped
    @objc func checkWord(_ sender: UIButton) {
        guard let word = word else { return }
        if word.searchWords.contains(wordInProgress.lowercased()) {
            print("Success: \(wordInProgress) is in search words")
        } else if word.bonusWords.contains(wordInProgress.lowercased()) {
            print("Success: \(wordInProgress) is in bonus words")
        } else {
            print("Try again: \(wordInProgress) is not a word")
        }
        resetWord(sender)
    }
}

// Extension to set up Collection View Delegate and Data Source.
extension WordSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainWord.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCell", for: indexPath)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitleColor(.black, for: .normal)
        let char = String(mainWord[indexPath.item])
        button.setTitle(char.capitalized, for: .normal)
        button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
        cell.addSubview(button)
        return cell
    }
}
