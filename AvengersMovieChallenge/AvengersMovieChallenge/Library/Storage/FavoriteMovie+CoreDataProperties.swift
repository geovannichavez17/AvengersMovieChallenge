//
//  FavoriteMovie+CoreDataProperties.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//
//

import Foundation
import CoreData

extension FavoriteMovie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var rating: Double
    @NSManaged public var createdAt: Date?
    
}

extension FavoriteMovie : Identifiable {
    
}
