//
//  NetworkProvider.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation

final class NetworkProvider {
    private let session: URLSession
    init(session: URLSession = .shared) { self.session = session }

    /*func request<T: Decodable>(_ target: TargetType, as type: T.Type) async throws -> T {
        let req = try target.asURLRequest()
        let (data, response) = try await session.data(for: req)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }*/
}
