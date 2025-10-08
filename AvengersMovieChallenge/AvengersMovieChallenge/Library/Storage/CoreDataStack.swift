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
            if let error { fatalError("Core Data error: \(error)") }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
