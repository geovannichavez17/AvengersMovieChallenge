//
//  MoviesTarget.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation

enum MoviesTarget {
    case createSession
    case searchMovie(query: String, page: Int)
    case movieDetail(id: Int)
}

extension MoviesTarget: TargetType {
    var path: String {
        switch self {
        case .createSession:
            return "/authentication/guest_session/new"
        case let .searchMovie(query, page):
            return "/search/movie?query=\(query)&page=\(page)"
        case .movieDetail(let id):
            return "/movie/\(id)"
        }
    }
    
    var method: TMDBRequestMethod {
        .get
    }
}
