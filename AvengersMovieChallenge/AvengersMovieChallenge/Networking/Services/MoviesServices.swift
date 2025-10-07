//
//  MoviesServices.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation
import Combine

protocol MoviesServiceType {
    func createSession() -> AnyPublisher<SessionToken, Error>
    func fetchMovies(query: String, on page: Int) -> AnyPublisher<PagedResponse<Movie>, Error>
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error>
}

protocol MoviesServiceDependenciesType {
    var networkService: NetworkClientType { get }
}

struct MoviesServiceDependencies: MoviesServiceDependenciesType {
    var networkService: NetworkClientType = NetworkClient()
}

struct MoviesService: MoviesServiceType {
    private let dependencies: MoviesServiceDependenciesType
    
    init(dependencies: MoviesServiceDependenciesType = MoviesServiceDependencies()) {
        self.dependencies = dependencies
    }
    
    func createSession() -> AnyPublisher<SessionToken, Error> {
        dependencies.networkService.request(MoviesTarget.createSession)
    }
    
    func fetchMovies(query: String, on page: Int) -> AnyPublisher<PagedResponse<Movie>, Error> {
        dependencies.networkService.request(MoviesTarget.searchMovie(query: query, page: page))
    }
    
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        dependencies.networkService.request(MoviesTarget.movieDetail(id: id))
    }
}
