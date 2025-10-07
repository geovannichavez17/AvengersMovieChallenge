//
//  MoviesTarget.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation

enum MoviesTarget {
    case searchMovie(query: String, page: Int)
    case movieDetail(id: Int)
    //case trailers(id: Int)
    //case crew(id: Int)
}

extension MoviesTarget: TargetType {
    var path: String {
        switch self {
        case let .searchMovie(query, page):
            return "/search/movie?query=\(query)&page=\(page)"
        case .movieDetail(let id):
            return "/movie/\(id)"
        /*case .trailers(let id):
            return "/movie/\(id)/videos"
            case .crew(let id):
                return "/movie/\(id)/credits"*/
        }
    }
    
    var method: TMDBRequestMethod {
        .get
    }
}
