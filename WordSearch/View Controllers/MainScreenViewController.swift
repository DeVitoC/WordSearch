//
//  MainScreenViewController.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/30/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    // MARK: - Properties
    let setupMethods = SetupUIMethods()
    lazy var topLabelSize: CGRect = {
        CGRect(x: 0, y: 0, width: 75, height: 20)
    }()
    lazy var imageButtonSize: CGRect = {
        CGRect(center: .zero, size: CGSize(width: 20, height: 20))
    }()
    lazy var playButtonSize: CGRect = {
        CGRect(center: .zero, size: CGSize(width: 300, height: 40))
    }()
    var mainStack = UIStackView()

    // MARK - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        setupView()

        // Do any additional setup after loading the view.
    }

    func setupView() {
        // Declare all variables, constants, and UI elements
        let settingsButton = createImageButton(frame: imageButtonSize, imageName: "gear", selector: #selector(settings(_:)))
        let currencyLabel = setupMethods.createLabel("\u{2665}100", frame: topLabelSize, alignment: .center, textColor: .systemOrange)
        let storeButton = createImageButton(frame: imageButtonSize, imageName: "cart", selector: #selector(store(_:)))
        let logoImageView = setupMethods.createImageView(systemImage: "box.fill", contentMode: .scaleAspectFit, heightAnchor: (view.frame.width / 5), widthAnchor: (view.frame.width * 2/3))
        let startLevelButton = createSelectGameButton(frame: playButtonSize, title: "Play Game", selector: #selector(startGame(_:)))
        let topBarStack = setupMethods.createElementStackView(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: ((view.frame.width - 50) / 3))


        // Set class declared properties
        mainStack = setupMethods.createElementStackView(axis: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 20)

        // Add all elements to respective parent views
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(topBarStack)
        mainStack.addArrangedSubview(logoImageView)
        mainStack.addArrangedSubview(startLevelButton)
        topBarStack.addArrangedSubview(storeButton)
        topBarStack.addArrangedSubview(currencyLabel)
        topBarStack.addArrangedSubview(settingsButton)

        // Set constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
//            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5)
        ])
    }

    func createImageButton(frame: CGRect, imageName: String, selector: Selector) -> UIButton {
        let button = UIButton(frame: frame)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)

        return button
    }

    func createSelectGameButton(frame: CGRect, title: String, selector: Selector) -> UIButton {
        let button = UIButton(frame: frame)
        button.layer.borderWidth = 2
        button.layer.borderColor = CGColor.init(srgbRed: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)

        return button
    }

    @objc func settings(_ button: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }

    @objc func store(_ button: UIButton) {
//        performSegue(withIdentifier: "StoreSegue", sender: self)
    }

    @objc func startGame(_ button: UIButton) {
        performSegue(withIdentifier: "PlayGameSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
