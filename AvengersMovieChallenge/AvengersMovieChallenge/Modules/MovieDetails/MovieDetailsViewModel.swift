//
//  MovieDetailsViewModel.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation
import Combine

protocol MoviedetailViewModelDependenciesType {
    var movieService: MoviesServiceType { get }
    var favoritesRepository: FavoritesRepositoryType { get }
}

struct MovieDetailViewModelDependencies: MoviedetailViewModelDependenciesType {
    let movieService: MoviesServiceType = MoviesService()
    let favoritesRepository: FavoritesRepositoryType = FavoritesRepositoryCoreData(stack: AppCoreDataStack())
}

class MovieDetailViewModel: ObservableObject {
    @Published private(set) var isFavorite = false
    @Published var movieDetail: MovieDetail?

    private let dependencies: MoviedetailViewModelDependenciesType
    private let movie: Movie
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        movie: Movie,
        dependencies: MoviedetailViewModelDependenciesType = MovieDetailViewModelDependencies()
    ) {
        self.movie = movie
        self.dependencies = dependencies
    }
    
    func fetchMovieInformation() {
        fetchMovieDetail()
        
        // Para que isFavorite no se quede desfasado hasta que el usuario toque el botón
        Task { await refreshFavoriteFlag() }
    }
    
    func toggleFavorite() {
        Task {
            do {
                let movieId = Int64(movie.id)
                if isFavorite { try await dependencies.favoritesRepository.remove(id: movieId)  }
                else { try await dependencies.favoritesRepository.add(movie) }
                await refreshFavoriteFlag()
            } catch { print("toggleFavorite error: \(error)") }
        }
    }
    
    private func fetchMovieDetail() {
        dependencies
            .movieService
            .getMovieDetail(id: movie.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] movieDetail in
                // Publicación de cambios obtenidos de respuesta de request
                self?.movieDetail = movieDetail
            }
            .store(in: &cancellables)
    }
    
    private func refreshFavoriteFlag() async {
        do {
            let value = try await dependencies.favoritesRepository.isFavorite(id: Int64(movie.id))
            // Se actualiza propiedades en el main thread
            await MainActor.run { self.isFavorite = value }
        } catch {
            // Se actualiza propiedades en el main thread
            await MainActor.run { self.isFavorite = false }
        }
    }
}

