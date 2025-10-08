//
//  MoviesViewModel.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation
import Combine

protocol MoviesViewModelDependenciesType {
    var moviesService: MoviesServiceType { get }
}

struct MoviesViewModelDependencies: MoviesViewModelDependenciesType {
    let moviesService: MoviesServiceType = MoviesService()
}

class MoviesViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var movies: [Movie] = []
    @Published var isFinished = false
    @Published var currentPage = 0
    @Published var selectedMovie: Movie?
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let dependencies: MoviesViewModelDependenciesType
    
    private var cancellables: Set<AnyCancellable> = []
    private var nextPage: Int {
        currentPage + 1
    }
    
    init(dependencies: MoviesViewModelDependenciesType = MoviesViewModelDependencies()) {
        self.dependencies = dependencies
    }
    
    func fetchMovies() {
        dependencies.moviesService
            .fetchMovies(query: "Avengers", on: nextPage) // Manda request con query de búsqueda
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveRequest: { [weak self] _ in
                guard let self = self else { return }
                self.isLoading = true
            })
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    print(error)
                    self.showError = true
                    self.errorMessage = K.generalError
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                // Publica los cambios según la respuesta
                self.movies += response.results
                self.isFinished = response.page == response.totalPages
                self.currentPage = response.page
            }
            .store(in: &cancellables)
    }
}
