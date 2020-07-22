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
    var gameBoardController = GameBoardController()
    private var word: Word {
        guard let word = gameBoardController.word else { fatalError() }
        return word
    }
    private var mainWord: [Character] {
        return Array(word.mainWord)
    }
    private var wordInProgress: String = ""
    private var gameBoard: GameBoard?
    private var letterMap: LetterMap?
    lazy var gameBoardMapStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var buttonsCollectionView = UICollectionView(frame: CGRect(center: .zero, size: CGSize(width: view.frame.width * 0.6, height: view.frame.width * 0.6)), collectionViewLayout: LetterButtonsLayout())
    lazy var activeAreaStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var inProgressLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var resultsLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var mapRows: Int {
        guard let letterMap = letterMap else { return 15 }
        let mapRows = 1 + letterMap.coordinateRange.high.y - letterMap.coordinateRange.low.y
        return mapRows
    }
    private var mapCols: Int {
        guard let letterMap = letterMap else { return 15 }
        let mapCols = 1 + letterMap.coordinateRange.high.x - letterMap.coordinateRange.low.x
        return mapCols
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        gameBoard = gameBoardController.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            letterMap = gameBoardController.createLetterMap(gameBoard: gameBoard)
        }
        updateViews()
    }

    private func updateViews() {
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.delegate = self

        print("mainword: \(word.mainWord), searchwords: \(word.searchWords.count), bonuswords: \(word.bonusWords.count)")
        generateGameBoardMap()
        generateActivePlayButtons()
        buttonsCollectionView.reloadData()
    }

    // MARK: - Set Up Methods
    /// Generates a grid of UILabels inside stacked UIStackViews for a map of the height and width of the letterMap plus 2
    private func generateGameBoardMap() {
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

    /// Populates Game Board Map with values from letterMap
    private func populateGameBoardMap() {
        guard let letterMap = letterMap else { return }

        for (coord, node) in letterMap.values {
            let xCoord = coord.x - letterMap.coordinateRange.low.x
            let yCoord = mapRows - (coord.y - letterMap.coordinateRange.low.y)
            guard let stack = gameBoardMapStackView.arrangedSubviews[yCoord] as? UIStackView,
                let label = stack.arrangedSubviews[xCoord] as? UILabel else { continue }
            label.text = String(node.value.uppercased())
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
        activeAreaStackView.spacing = 0
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
        inProgressLabel.font = .boldSystemFont(ofSize: 20)
        inProgressLabel.text = ""
        inProgressLabel.textColor = .systemBlue
        activeAreaStackView.addArrangedSubview(inProgressLabel)

        // modify and add results UILabel
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.textAlignment = .center
        resultsLabel.font = .boldSystemFont(ofSize: 20)
        resultsLabel.text = " "
        resultsLabel.textColor = .systemBlue
        activeAreaStackView.addArrangedSubview(resultsLabel)

        // create and add UIStackView for reset and check word UIButtons
        let controlButtonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        controlButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlButtonsStackView.axis = .horizontal
        controlButtonsStackView.alignment = .center
        controlButtonsStackView.distribution = .fillEqually
        controlButtonsStackView.spacing = 10
        activeAreaStackView.addArrangedSubview(controlButtonsStackView)

        // add reset and check word UIButtons to controlButtonsStackView
        controlButtonsStackView.addArrangedSubview(generateSingleButton(backgroundColor: .systemBlue, titleText: "Reset Word", action: #selector(resetWord(_:))))
        controlButtonsStackView.addArrangedSubview(generateSingleButton(backgroundColor: .systemTeal, titleText: "Check Word", action: #selector(checkWord(_:))))
        controlButtonsStackView.addArrangedSubview(generateSingleButton(backgroundColor: .systemIndigo, titleText: "New Board", action: #selector(resetBoard(_:))))
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

    /// Generates and returns a UIButton to with the passed background color, title text, and selector
    private func generateSingleButton(backgroundColor color: UIColor, titleText: String, action selector: Selector) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = color
        button.setTitleColor(.black, for: .normal)
        button.setTitle(titleText, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
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
    @objc func resetWord(_ sender: Any) {
        wordInProgress = ""
        inProgressLabel.text = ""

        for num in 0...buttonsCollectionView.numberOfItems(inSection: 0) {
            if let button = buttonsCollectionView.cellForItem(at: IndexPath(item: num, section: 0))?.subviews[1] as? UIButton {
                button.isSelected = false
            }
        }
    }

    /// Defines the action taken when the check word button is tapped
    @objc func checkWord(_ sender: UIButton) {
        guard wordInProgress != "" else {
            resultsLabel.text = "You need to enter a word!"
            return
        }
        if word.searchWords.contains(wordInProgress.lowercased()) {
            resultsLabel.text = "Success: \(wordInProgress) is in search words"
        } else if word.bonusWords.contains(wordInProgress.lowercased()) {
            resultsLabel.text = "Success: \(wordInProgress) is in bonus words"
        } else {
            resultsLabel.text = "Try again: \(wordInProgress) is not a word"
        }
        resetWord(sender)
    }

    /// Defines the action taken when the reset board button is tapped
    @objc func resetBoard(_ sender: UIButton) {
        wordInProgress = ""
        gameBoardMapStackView.removeFromSuperview()
        buttonsStackView.removeFromSuperview()
        buttonsCollectionView.removeFromSuperview()
        activeAreaStackView.removeFromSuperview()
        inProgressLabel.removeFromSuperview()
        resultsLabel.removeFromSuperview()
        gameBoardMapStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        buttonsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        buttonsCollectionView = UICollectionView(frame: CGRect(center: .zero, size: CGSize(width: view.frame.width * 0.6, height: view.frame.width * 0.6)), collectionViewLayout: LetterButtonsLayout())
        activeAreaStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        inProgressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        resultsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        gameBoardController = GameBoardController()
        gameBoard = gameBoardController.createGameBoard(level: 201)
        if let gameBoard = gameBoard {
            letterMap = gameBoardController.createLetterMap(gameBoard: gameBoard)
        }
        
        updateViews()
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
