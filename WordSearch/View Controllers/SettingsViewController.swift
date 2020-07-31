//
//  SettingsViewController.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/30/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

/// UserSettings enum for UserDefaults and Segmented Controls
enum UserSettings: String {
    case on = "ON"
    case off = "OFF"
}

enum DefaultKeys: String {
    case music
    case sound
    case notifications
    case language
}

class SettingsViewController: UIViewController {

    // MARK: - Properties
    var mainStack = UIStackView()
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let defaults = UserDefaults.standard
    let languages = ["English", "Spanish", "German"]

    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        setupView()
    }

    /// Updates view when settings are changed
    func updateViews() {

    }

    /// Generates the UI for the Settings View Controller, including all UI Elements
    func setupView() {
        // Declare all variables, constants, and UI elements
        let itemLabelSize = CGRect(x: 0, y: 0, width: 150, height: 50)
        let sectionLabelSize = CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 50)
        let segmentedItems: [String] = [UserSettings.on.rawValue, UserSettings.off.rawValue]
        let soundSectionLabel = createLabel("SOUND SETTINGS", frame: sectionLabelSize, alignment: .center)
        let soundLabel = createLabel("Sound", frame: itemLabelSize, alignment: .left)
        let musicLabel = createLabel("Music", frame: itemLabelSize, alignment: .left)
        let notificationsLabel = createLabel("Notifications", frame: itemLabelSize, alignment: .left)
        let soundSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.sound.rawValue, tag: 1)
        let musicSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.music.rawValue, tag: 0)
        let otherSectionLabel = createLabel("OTHER", frame: sectionLabelSize, alignment: .center)
        let notificationsSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.notifications.rawValue, tag: 2)
        let languagePicker = createLanguagePicker()
        let soundStack = createElementStackView()
        let musicStack = createElementStackView()
        let notificationStack = createElementStackView()
        let soundImage = createImageView(systemImage: "speaker.2.fill")
        let musicImage = createImageView(systemImage: "music.note")
        let notificationImage = createImageView(systemImage: "envelope.fill")

        // Set class declared properties
        titleLabel = createLabel("SETTINGS", frame: CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 75), alignment: .center)
        titleLabel.font = .systemFont(ofSize: 36)
        mainStack = createElementStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .fill

        // Add all elements to respective parent views
        view.addSubview(titleLabel)
        view.addSubview(mainStack)
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
        ])
    }

    // MARK: - Setup Helper Methods
    func createLabel(_ title: String, frame: CGRect, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = alignment
        label.textColor = .white

        return label
    }

    func createElementStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5

        return stackView
    }

    func createImageView(systemImage: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemImage))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true

        return imageView
    }

    func createSegmentedControl(segmentNames: [String], defaultKey: DefaultKeys.RawValue, tag: Int) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: segmentNames)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let value = defaults.optionalBool(forKey: defaultKey) ?? true
        segmentedControl.selectedSegmentIndex = value ? 0 : 1
        segmentedControl.tag = tag
        segmentedControl.addTarget(self, action: #selector(scValueChanged(_:)), for: .valueChanged)

        return segmentedControl
    }

    func createLanguagePicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        let defaultValue = defaults.string(forKey: DefaultKeys.language.rawValue) ?? languages[0]
        let value = languages.firstIndex(of: defaultValue) ?? 0
        picker.selectRow(value, inComponent: 1, animated: false)

        return picker
    }

    @objc func scValueChanged(_ segmentedControl: UISegmentedControl) {
        var key: String
        if segmentedControl.tag == 0 {
            key = DefaultKeys.music.rawValue
        } else if segmentedControl.tag == 1 {
            key = DefaultKeys.sound.rawValue
        } else {
            key = DefaultKeys.notifications.rawValue
        }

        if var value = defaults.optionalBool(forKey: key) {
            value.toggle()
            defaults.setOptionalBool(value: value, forKey: key)
        } else {
            defaults.setOptionalBool(value: false, forKey: key)
        }
    }
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        } else {
            return languages.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "Language"
        } else {
            return languages[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            defaults.set(languages[row], forKey: DefaultKeys.language.rawValue)
        }
    }
}
