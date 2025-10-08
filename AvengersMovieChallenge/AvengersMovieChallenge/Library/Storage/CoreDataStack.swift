//
//  CoreDataStack.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import Foundation
import CoreData

protocol CoreDataStackType: Sendable {
    var container: NSPersistentContainer { get }
}

public final class AppCoreDataStack: CoreDataStackType {
    public let container: NSPersistentContainer

    public init(modelName: String = "AvengersMovieData") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            #if DEBUG
            if let error { assertionFailure("Core Data error: \(error)") }
            #else
            if let error { NSLog("Core Data error: \(error.localizedDescription)") }
            #endif
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
