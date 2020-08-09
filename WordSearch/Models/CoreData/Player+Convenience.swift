//
//  Player+Convenience.swift
//  WordSearch
//
//  Created by Christopher Devito on 8/9/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import CoreData

extension Player {
    convenience init(firstName: String? = nil,
                     lastName: String? = nil,
                     level: Int = 0,
                     coins: Int = 0,
                     cats: Int = 0,
                     dogs: Int = 0,
                     dolphins: Int = 0,
                     lastDailyGift: Date = Date(),
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.firstName = firstName
        self.lastName = lastName
        self.level = Int16(level)
        self.coins = Int16(coins)
        self.cats = Int16(cats)
        self.dogs = Int16(dogs)
        self.dolphins = Int16(dolphins)
        self.lastDailyGift = lastDailyGift
    }
}
