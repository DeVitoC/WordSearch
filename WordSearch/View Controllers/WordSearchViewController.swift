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
//    let gameBoardController = GameBoardController()
    let gameBoardControllerTest = GameBoardControllerTest()
    private var word: Word {
        guard let word = gameBoardControllerTest.word else { fatalError() }
        return word
    }
    lazy var mainWord: [Character] = {
        return Array(word.mainWord)
    }()
    private var wordInProgress: String = ""
    private var gameBoard: GameBoard?

//    private var wordMap: [[Character?]] = [] {
//        didSet {
//            updateViews()
//        }
//    }
    private var letterMap: LetterMap?
    lazy var gameBoardMapStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsCollectionView = UICollectionView(frame: CGRect(center: .zero, size: CGSize(width: view.frame.width * 0.6, height: view.frame.width * 0.6)), collectionViewLayout: LetterButtonsLayout())
    lazy var activeAreaStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var inProgressLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.delegate = self
        gameBoard = gameBoardControllerTest.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            letterMap = gameBoardControllerTest.createWordMap(gameBoard: gameBoard)
        }
        updateViews()
        print("mainword: \(word.mainWord), searchwords: \(word.searchWords.count), bonuswords: \(word.bonusWords.count)")
    }

    private func updateViews() {
        generateGameBoardMap()
        generateActivePlayButtons()
    }

    // MARK: - Set Up Methods
    /// Generates a grid of UILabels inside stacked UIStackViews for a map of the height and width of the letterMap plus 2
    private func generateGameBoardMap() {
        guard let letterMap = letterMap else { fatalError() }
        let mapRows = 1 + letterMap.coordinateRange.high.y - letterMap.coordinateRange.low.y
        let mapCols = 1 + letterMap.coordinateRange.high.x - letterMap.coordinateRange.low.y
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
            gameBoardMapStackView.heightAnchor.constraint(equalTo: gameBoardMapStackView.widthAnchor),
        ])

        // Add stacks of UIStackViews - "gameBoardMapStackView.arrangedSubViews[] as UIStackView"
        for _ in 0..<mapRows + 2 {
            let subStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 25))
            gameBoardMapStackView.addArrangedSubview(subStack)
            subStack.axis = .horizontal
            subStack.distribution = .fillEqually
            subStack.alignment = .fill
        }

        // Add row of (the height of the letterMap + 2) labels in sub-stackviews with text " "
        for y in 0..<mapRows + 2 {
            for _ in 0..<mapCols + 2 {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
                label.text = " "
                (gameBoardMapStackView.arrangedSubviews[y] as! UIStackView).addArrangedSubview(label)
            }
        }
        populateGameBoardMap()
    }

    /// Populates Game Board Map with values from wordMap
    private func populateGameBoardMap() {
        guard let letterMap = letterMap else { return }
        let mapRows = 1 + letterMap.coordinateRange.high.y - letterMap.coordinateRange.low.y

        for (char, value) in letterMap.values {
            for (_, coord) in value {
                let xCoord = coord.x - letterMap.coordinateRange.low.x
                let yCoord = mapRows - (coord.y - letterMap.coordinateRange.low.y)
                guard let stack = gameBoardMapStackView.arrangedSubviews[yCoord] as? UIStackView,
                    let label = stack.arrangedSubviews[xCoord] as? UILabel else { continue }
                label.text = String(char)
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

        // modify and add in progress word UILabel
        inProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        inProgressLabel.textAlignment = .center
        inProgressLabel.font = .boldSystemFont(ofSize: 24)
        inProgressLabel.text = ""
        inProgressLabel.textColor = .systemBlue
        activeAreaStackView.addArrangedSubview(inProgressLabel)

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
            let index = String.Index(utf16Offset: wordInProgress.count - 1, in: wordInProgress)
            wordInProgress.remove(at: index)
            var wordLabelText = inProgressLabel.text
            wordLabelText?.remove(at: index)
            inProgressLabel.text = wordLabelText
            // TODO: - finish logic
        } else {
            sender.isSelected = true
            guard let letter = sender.titleLabel?.text,
                let inProgressText = inProgressLabel.text else { return }
            wordInProgress.append(letter)
            inProgressLabel.text = "\(inProgressText)\(letter)"
        }
    }

    /// Defines the action taken when the reset button is tapped
    @objc func resetWord(_ sender: UIButton) {
        wordInProgress = ""
        inProgressLabel.text = ""
        for num in 0...5 {
            if let button = buttonsCollectionView.cellForItem(at: IndexPath(item: num, section: 0))?.subviews[1] as? UIButton {
                button.isSelected = false
            }
        }
    }

    /// Defines the action taken when the check word button is tapped
    @objc func checkWord(_ sender: UIButton) {
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
