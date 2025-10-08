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
    @Published var movieDetailId: Int?
    
    private let dependencies: MoviesViewModelDependenciesType
    
    private var cancellables: Set<AnyCancellable> = []
    private var nextPage: Int {
        currentPage + 1
    }
    
    init(dependencies: MoviesViewModelDependenciesType = MoviesViewModelDependencies()) {
        self.dependencies = dependencies
    }
    
    func fetchNowPlaying() {
        dependencies.moviesService
            .fetchMovies(query: "Avengers", on: nextPage)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveRequest: { [weak self] _ in
                self?.isLoading = true
            })
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.movies += response.results
                self?.isFinished = response.page == response.totalPages
                self?.currentPage = response.page
            }
            .store(in: &cancellables)
    }
}
