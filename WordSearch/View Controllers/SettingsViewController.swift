//
//  SettingsViewController.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/30/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

/// Enum to describe the UserDefaults values and Segmented Controls items
enum UserSettings: String {
    /// Sets Segmented Control item to "ON" or UserDefaults to "ON"
    case on = "ON"
    /// Sets Segmented Control item to "OFF" or UserDefaults to "OFF"
    case off = "OFF"
}

/// Enum to describe the UserDefault keys for various UI elements
enum DefaultKeys: String {
    case music
    case sound
    case notifications
    case language
}

/// View Controller for Settings page
class SettingsViewController: UIViewController {

    // MARK: - Properties
    /// The main UIStackView for the Settings page
    var mainStack = UIStackView()
    /// The title UILabel for the Settings page
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    /// The "DONE" UIButton for the Settings page
    let doneButton = UIButton(type: .roundedRect)
    /// The property to access the UserDefaults.standard
    let defaults = UserDefaults.standard
    /// An instance of the SetupUIMethods to call on to set up the UI Elements
    let setupMethods = SetupUIMethods()
    /// The property that defines the settings items Label sizes
    lazy var itemLabelSize: CGRect = {
        CGRect(x: 0, y: 0, width: 150, height: 50)
    }()
    /// The property that defines the section Label sizes
    lazy var sectionLabelSize: CGRect = {
        CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 50)
    }()

    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        setupView()
    }

    /// Generates the UI for the Settings View Controller, including all UI Elements
    func setupView() {
        // Declare all variables, constants, and UI elements
        let segmentedItems: [String] = [UserSettings.on.rawValue, UserSettings.off.rawValue]
        let soundSectionLabel = setupMethods.createLabel("SOUND SETTINGS", frame: sectionLabelSize, alignment: .center)
        let soundLabel = setupMethods.createLabel("Sound", frame: itemLabelSize, alignment: .left)
        let musicLabel = setupMethods.createLabel("Music", frame: itemLabelSize, alignment: .left)
        let notificationsLabel = setupMethods.createLabel("Notifications", frame: itemLabelSize, alignment: .left)
        let soundSC = setupMethods.createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.sound.rawValue, tag: 1)
        let musicSC = setupMethods.createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.music.rawValue, tag: 0)
        let otherSectionLabel = setupMethods.createLabel("OTHER", frame: sectionLabelSize, alignment: .center)
        let notificationsSC = setupMethods.createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.notifications.rawValue, tag: 2)
        let languagePicker = setupMethods.createLanguagePicker()
        let soundStack = setupMethods.createElementStackView()
        let musicStack = setupMethods.createElementStackView()
        let notificationStack = setupMethods.createElementStackView()
        let soundImage = setupMethods.createImageView(systemImage: "speaker.2.fill")
        let musicImage = setupMethods.createImageView(systemImage: "music.note")
        let notificationImage = setupMethods.createImageView(systemImage: "envelope.fill")

        // Set class declared properties
        titleLabel = setupMethods.createLabel("SETTINGS", frame: CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 75), alignment: .center)
        titleLabel.font = .systemFont(ofSize: 36)
        mainStack = setupMethods.createElementStackView(axis: .vertical, alignment: .fill)
        doneButton.setTitle("DONE", for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .lightGray
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped(_:)), for: .touchUpInside)

        // Add all elements to respective parent views
        view.addSubview(titleLabel)
        view.addSubview(mainStack)
        view.addSubview(doneButton)
        mainStack.addArrangedSubview(soundSectionLabel)
        mainStack.addArrangedSubview(soundStack)
        mainStack.addArrangedSubview(musicStack)
        mainStack.addArrangedSubview(otherSectionLabel)
        mainStack.addArrangedSubview(notificationStack)
        mainStack.addArrangedSubview(languagePicker)
        soundStack.addArrangedSubview(soundImage)
        soundStack.addArrangedSubview(soundLabel)
        soundStack.addArrangedSubview(soundSC)
        musicStack.addArrangedSubview(musicImage)
        musicStack.addArrangedSubview(musicLabel)
        musicStack.addArrangedSubview(musicSC)
        notificationStack.addArrangedSubview(notificationImage)
        notificationStack.addArrangedSubview(notificationsLabel)
        notificationStack.addArrangedSubview(notificationsSC)

        // Set constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            mainStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    // MARK: - Action Methods
//    @objc func scValueChanged(_ segmentedControl: UISegmentedControl) {
//        var key: String
//        if segmentedControl.tag == 0 {
//            key = DefaultKeys.music.rawValue
//        } else if segmentedControl.tag == 1 {
//            key = DefaultKeys.sound.rawValue
//        } else {
//            key = DefaultKeys.notifications.rawValue
//        }
//
//        if var value = defaults.optionalBool(forKey: key) {
//            value.toggle()
//            defaults.setOptionalBool(value: value, forKey: key)
//        } else {
//            defaults.setOptionalBool(value: false, forKey: key)
//        }
//    }

    /// Action that describes what happens when "DONE" button is tapped
    /// - Parameter button: The sending **UIButton**.
    @objc func doneTapped(_ button: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
