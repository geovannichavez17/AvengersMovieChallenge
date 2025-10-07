//
//  Models.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let originalLanguage: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
    }
}


struct MovieDetail: Decodable {
    let title: String
    let overview: String
    let backgroundImage: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case backgroundImage = "backdrop_path"
        case voteAverage = "vote_average"
    }
}

struct PagedResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SessionToken: Codable, Hashable {
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "guest_session_id"
    }
}
