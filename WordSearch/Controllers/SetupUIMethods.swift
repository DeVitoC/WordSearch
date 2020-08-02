//
//  SetupUIMethods.swift
//  WordSearch
//
//  Created by Christopher Devito on 8/1/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

/// Class with methods to set up UI Elements.
class SetupUIMethods: NSObject {
    // MARK: - Properties
    /// Constant property to access UserDefaults.standard.
    let defaults = UserDefaults.standard
    /// Constant property of type **Array<String>** containing list of language names.
    let languages = ["English", "Spanish", "German", "Italian", "French", "Dutch", "Danish"]

    /// Generates the UI for the Settings View Controller, including all UI Elements
//    func setupView() {
//        // Declare all variables, constants, and UI elements
//        let segmentedItems: [String] = [UserSettings.on.rawValue, UserSettings.off.rawValue]
//        let soundSectionLabel = createLabel("SOUND SETTINGS", frame: sectionLabelSize, alignment: .center)
//        let soundLabel = createLabel("Sound", frame: itemLabelSize, alignment: .left)
//        let musicLabel = createLabel("Music", frame: itemLabelSize, alignment: .left)
//        let notificationsLabel = createLabel("Notifications", frame: itemLabelSize, alignment: .left)
//        let soundSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.sound.rawValue, tag: 1)
//        let musicSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.music.rawValue, tag: 0)
//        let otherSectionLabel = createLabel("OTHER", frame: sectionLabelSize, alignment: .center)
//        let notificationsSC = createSegmentedControl(segmentNames: segmentedItems, defaultKey: DefaultKeys.notifications.rawValue, tag: 2)
//        let languagePicker = createLanguagePicker()
//        let soundStack = createElementStackView()
//        let musicStack = createElementStackView()
//        let notificationStack = createElementStackView()
//        let soundImage = createImageView(systemImage: "speaker.2.fill")
//        let musicImage = createImageView(systemImage: "music.note")
//        let notificationImage = createImageView(systemImage: "envelope.fill")
//
//
//        // Set class declared properties
//        //titleLabel = createLabel("SETTINGS", frame: CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 75), alignment: .center)
//        //titleLabel.font = .systemFont(ofSize: 36)
//        //mainStack = createElementStackView()
//        //mainStack.axis = .vertical
//        //mainStack.alignment = .fill
//        //doneButton.setTitle("DONE", for: .normal)
//        //doneButton.translatesAutoresizingMaskIntoConstraints = false
//        //doneButton.addTarget(self, action: #selector(doneTapped(_:)), for: .touchUpInside)
//
//
//        // Add all elements to respective parent views
////        view.addSubview(titleLabel)
////        view.addSubview(mainStack)
////        view.addSubview(doneButton)
////        mainStack.addArrangedSubview(soundSectionLabel)
////        mainStack.addArrangedSubview(soundStack)
////        mainStack.addArrangedSubview(musicStack)
////        mainStack.addArrangedSubview(otherSectionLabel)
////        mainStack.addArrangedSubview(notificationStack)
////        mainStack.addArrangedSubview(languagePicker)
//        soundStack.addArrangedSubview(soundImage)
//        soundStack.addArrangedSubview(soundLabel)
//        soundStack.addArrangedSubview(soundSC)
//        musicStack.addArrangedSubview(musicImage)
//        musicStack.addArrangedSubview(musicLabel)
//        musicStack.addArrangedSubview(musicSC)
//        notificationStack.addArrangedSubview(notificationImage)
//        notificationStack.addArrangedSubview(notificationsLabel)
//        notificationStack.addArrangedSubview(notificationsSC)
//
//        // Set constraints
//        NSLayoutConstraint.activate([
//            mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            mainStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            mainStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            doneButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20),
//            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            doneButton.widthAnchor.constraint(equalToConstant: 100),
//            doneButton.heightAnchor.constraint(equalToConstant: 50),
//        ])
//    }

    // MARK: - UI Element Setup Methods

    /**
     Create a UILabel with title, frame and alignment passed in.

        - Parameter title: **String** that describes the UILabel's text property
        - Parameter frame: **CGRect** that describes the initial dimensions of the UILabel
        - Parameter alignment: **NSTextAlignment** that describes the UILabel's  textAlignment property
        - Parameter textColor: **UIColor** that describes the UILabel's textColor property
        - Returns: A **UILabel** set up to the specifications passed in.
    */
    func createLabel(_ title: String, frame: CGRect, alignment: NSTextAlignment, textColor: UIColor = .white) -> UILabel {
        let label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = alignment
        label.textColor = textColor

        return label
    }

    /**
     Create a UIStackView with title, frame, alignment and textColor passed in.

        - Parameter axis: **NSLayoutConstraint.Axis** that describes the UIStackView's axis property
        - Parameter alignment: **UIStackView.Alignment** that describes the UIStackView's alignment property
        - Parameter distribution: **UIStackView.Distribution** that describes the UIStackView's distribution property
        - Parameter spacing: **CGFloat** that describes the UIStackView's spacing property
        - Returns: A **UIStackView** set up to the the passed in specifications.
     */
    func createElementStackView(axis: NSLayoutConstraint.Axis = .horizontal, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fillEqually, spacing: CGFloat = 5) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing

        return stackView
    }

    /**
    Create a UIImageView with systemImage, contentMode, heightAnchor, and widthAnchor passed in.

     - Parameter systemImage: **String** that describes the UIImageView's UIImage systemName
     - Parameter contentMode: **UIView.ContentMode** that describes the UIImageView's contentMode
     - Parameter heightAnchor: **CGFloat** that describes the UIImageView's height
     - Parameter widthAnchor: **CGFloat** that describes the UIImageView's width
     */
    func createImageView(systemImage: String, contentMode: UIView.ContentMode = .scaleAspectFit, heightAnchor: CGFloat = 25, widthAnchor: CGFloat = 25) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemImage))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = contentMode
        imageView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true

        return imageView
    }

    /**
     Create a UISegmentedControl with segmentNames, defaultKey, tag,  passed in.

     - Parameter segmentNames: **Array<String>** that describes the UISegmentControl's items
     - Parameter defaultKey: **DefaultKeys.RawValue** that describes the UISegmentControl's UserDefault key
     - Parameter tag: **Int** that describes the UISegmentControl's tag value
     - Returns: A **UISegmentedControl** set up to toggle between "ON" and "OFF" for the passed in UserDefault.
     */
    func createSegmentedControl(segmentNames: [String], defaultKey: DefaultKeys.RawValue, tag: Int) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: segmentNames)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let value = defaults.optionalBool(forKey: defaultKey) ?? true
        segmentedControl.selectedSegmentIndex = value ? 0 : 1
        segmentedControl.tag = tag
        segmentedControl.addTarget(self, action: #selector(scValueChanged(_:)), for: .valueChanged)

        return segmentedControl
    }

    ///Create a UIPickerView for selecting a user's preferred language.
    ///- Returns: A **UIPickerView** to use for selecting a user's preferred language.
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

    // Action Methods

    /** Defines the action that occurs when UISegmentedControls are toggled. Toggles UserDefault for selected UISegmentedControl on and off.

- Parameter segmentedControl: **UISegmentedControl** the sending UISegmentedControl
     */
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

extension SetupUIMethods: UIPickerViewDataSource, UIPickerViewDelegate {
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
