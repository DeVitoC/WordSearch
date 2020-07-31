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

class SettingsViewController: UIViewController {

    // MARK: - Properties
    var mainStack = UIStackView()
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let defaults = UserDefaults.standard

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
        let otherSectionLabel = createLabel("OTHER", frame: sectionLabelSize, alignment: .center)
        let notificationsLabel = createLabel("Notifications", frame: itemLabelSize, alignment: .left)
        let soundSC = createSegmentedControl(segmentNames: segmentedItems)
        let musicSC = createSegmentedControl(segmentNames: segmentedItems)
        let notificationsSC = createSegmentedControl(segmentNames: segmentedItems)
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

        // Set tamic to falce

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

    func createSegmentedControl(segmentNames: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: segmentNames)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
    }

    func createLanguagePicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self

        return picker
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

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        } else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "Language"
        } else {
            return "English"
        }
    }
}
