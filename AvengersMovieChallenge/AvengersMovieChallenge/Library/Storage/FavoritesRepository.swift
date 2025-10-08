//
//  FavoritesRepository.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import Foundation
import CoreData

protocol FavoritesRepositoryType: Sendable {
    func isFavorite(id: Int64) async throws -> Bool
    func add(_ movie: Movie) async throws
    func remove(id: Int64) async throws
    func all() async throws -> [FavoriteMovie]
}


final class FavoritesRepositoryCoreData: FavoritesRepositoryType {
    private let stack: CoreDataStackType

    public init(stack: CoreDataStackType) {
        self.stack = stack
        stack.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    public func isFavorite(id: Int64) async throws -> Bool {
        let ctx = stack.container.viewContext
        return try await ctx.perform {
            let req: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            req.predicate = NSPredicate(format: "id == %d", id)
            req.fetchLimit = 1
            return try ctx.count(for: req) > 0
        }
        /*return try await stack.container.performBackgroundTask { ctx in
            let req: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            req.predicate = NSPredicate(format: "id == %d", id)
            req.fetchLimit = 1
            return try ctx.count(for: req) > 0
        }*/
    }

    public func add(_ movie: Movie) async throws {
        try await stack.container.performBackgroundTask { ctx in
            let obj = FavoriteMovie(context: ctx)
            obj.id = Int64(movie.id)
            obj.title = movie.title
            obj.posterPath = movie.posterPath
            obj.releaseDate = movie.releaseDate
            obj.rating = movie.voteAverage ?? 0
            obj.createdAt = Date()
            try ctx.save()
        }
    }

    public func remove(id: Int64) async throws {
        try await stack.container.performBackgroundTask { ctx in
            let req: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            req.predicate = NSPredicate(format: "id == %d", id)
            for obj in try ctx.fetch(req) { ctx.delete(obj) }
            try ctx.save()
        }
    }

    public func all() async throws -> [FavoriteMovie] {
        let ctx = stack.container.viewContext
        return try await ctx.perform {
            let req: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            req.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            return try ctx.fetch(req)
        }
    }
}

/*
final class FavoritesRepository {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func isFavorite(id: Int64) async throws -> Bool {
        try await container.viewContext.perform {
            let req = FavoriteMovie.fetchRequest()
            req.predicate = NSPredicate(format: "id == %d", id)
            req.fetchLimit = 1
            return try self.container.viewContext.count(for: req) > 0
        }
    }

    func add(_ movie: Movie) async throws {
        try await container.performBackgroundTask { ctx in
            let obj = FavoriteMovie(context: ctx)
            obj.id = Int64(movie.id)
            obj.title = movie.title
            obj.posterPath = movie.posterPath
            obj.releaseDate = movie.releaseDate
            obj.rating = movie.voteAverage ?? 0
            obj.createdAt = Date()
            try ctx.save()
        }
    }

    func remove(id: Int64) async throws {
        try await container.performBackgroundTask { ctx in
            let req: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            req.predicate = NSPredicate(format: "id == %d", id)
            let results = try ctx.fetch(req)
            results.forEach(ctx.delete)
            try ctx.save()
        }
    }

    func all() async throws -> [FavoriteMovie] {
        try await container.viewContext.perform {
            let req = FavoriteMovie.fetchRequest()
            req.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            return try self.container.viewContext.fetch(req)
        }
    }
}
*/
