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
    var networkClient: NetworkClientType { get }
}

struct MoviesServiceDependencies: MoviesServiceDependenciesType {
    var networkClient: NetworkClientType = NetworkClient()
}

struct MoviesService: MoviesServiceType {
    private let dependencies: MoviesServiceDependenciesType
    
    init(dependencies: MoviesServiceDependenciesType = MoviesServiceDependencies()) {
        self.dependencies = dependencies
    }
    
    func createSession() -> AnyPublisher<SessionToken, Error> {
        dependencies.networkClient.request(MoviesTarget.createSession)
    }
    
    func fetchMovies(query: String, on page: Int) -> AnyPublisher<PagedResponse<Movie>, Error> {
        dependencies.networkClient.request(MoviesTarget.searchMovie(query: query, page: page))
    }
    
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        dependencies.networkClient.request(MoviesTarget.movieDetail(id: id))
    }
}
