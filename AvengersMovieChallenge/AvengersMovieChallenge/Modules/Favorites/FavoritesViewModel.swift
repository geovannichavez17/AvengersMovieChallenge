//
//  FavoritesViewModel.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import Foundation
import CoreData

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: FavoritesRepositoryType

    init(repository: FavoritesRepositoryType = FavoritesRepositoryCoreData(stack: AppCoreDataStack())) {
        self.repository = repository
    }

    func loadFavorites() {
        isLoading = true
        Task {
            do {
                let items = try await repository.getAll()
                guard !items.isEmpty else {
                    isLoading = false
                    return
                }
                
                favorites = items.map { favorite in
                    let movie = Movie(
                        id: Int(favorite.id),
                        title: favorite.title,
                        overview: nil,
                        releaseDate: favorite.releaseDate,
                        posterPath: favorite.posterPath,
                        originalLanguage: nil,
                        voteAverage: favorite.rating)
                    return movie
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
