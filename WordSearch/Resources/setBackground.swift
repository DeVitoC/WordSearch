//
//  setBackground.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/27/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

extension UIView {
    func setBackground(toImageNamed image: String = "dave-sBga13mu80c-unsplash.jpg") {
        guard let backgroundImage = UIImage(named: image) else { return }
        let backgroundImageView = UIImageView(frame: self.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.5))!
        self.insertSubview(backgroundImageView, at: 0)
    }

    func setBackgroundDark(toImageNamed image: String = "dave-sBga13mu80c-unsplash.jpg") {
        guard let backgroundImage = UIImage(named: image) else { return }
        let backgroundImageView = UIImageView(frame: self.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.75))!
        self.insertSubview(backgroundImageView, at: 0)
    }
}
