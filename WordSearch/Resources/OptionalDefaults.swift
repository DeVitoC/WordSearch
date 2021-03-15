//
//  OptionalDefaults.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/31/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

extension UserDefaults {
    public func optionalBool(forKey defaultName: String) -> Bool? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Bool
        }
        return nil
    }

    public func setOptionalBool(value: Bool?, forKey key: String) {
        let defaults = self
        defaults.set(value, forKey: key)
    }
}
