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
}

struct MovieDetailViewModelDependencies: MoviedetailViewModelDependenciesType {
    var movieService: MoviesServiceType = MoviesService()
}

class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetail?
    //@Published var movieVideos: [MovieVideo] = []
    //@Published var crewList: [Crew] = []
    
    private let dependencies: MoviedetailViewModelDependenciesType
    private let movieId: Int
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        movieId: Int,
        dependencies: MoviedetailViewModelDependenciesType = MovieDetailViewModelDependencies()
    ) {
        self.movieId = movieId
        self.dependencies = dependencies
    }
    
    func fetchMovieInformation() {
        fetchMovieDetail()
        //fetchMovieVideos()
        //fetchCrewList()
    }
    
    private func fetchMovieDetail() {
        dependencies
            .movieService
            .getMovieDetail(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] movieDetail in
                self?.movieDetail = movieDetail
            }
            .store(in: &cancellables)
    }
    
    /*private func fetchMovieVideos() {
        dependencies
            .movieService
            .fetchMovieVideos(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] movieVideosResponse in
                self?.movieVideos = movieVideosResponse
                    .results
                    .filter { $0.site == Constants.youtubeName && $0.official }
            }
            .store(in: &cancellables)
    }*/
    
    /*private func fetchCrewList() {
        dependencies
            .movieService
            .fetchCrew(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] crewResponse in
                self?.crewList = crewResponse.cast
            }
            .store(in: &cancellables)
    }*/
}

