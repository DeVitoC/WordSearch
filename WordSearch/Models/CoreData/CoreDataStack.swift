//
//  CoreDataStack.swift
//  WordSearch
//
//  Created by Christopher Devito on 8/9/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Player")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()

    var mainContext: NSManagedObjectContext {
        container.viewContext
    }
}
