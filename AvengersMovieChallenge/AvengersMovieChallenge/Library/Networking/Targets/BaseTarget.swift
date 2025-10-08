//
//  BaseTarget.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation


enum TMDBRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: TMDBRequestMethod { get }
    var headers: [String: String]? { get }
}

extension TargetType {
    var baseURL: String {
        K.baseUrl
    }
    
    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(K.apiKey)",
            "accept": "application/json"
        ]
    }
}
