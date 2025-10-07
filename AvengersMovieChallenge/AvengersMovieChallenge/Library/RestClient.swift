//
//  RestClient.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 7/10/25.
//

import Foundation
import Combine

final class RestClient {
    private let apiKey: String
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let urlSession: URLSession

    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = session
    }

    /// Construye una URL con query params de forma segura
    private func makeURL(path: String, queryItems: [URLQueryItem]) -> URL {
        var comps = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        var items = queryItems
        items.append(URLQueryItem(name: "api_key", value: apiKey))
        comps.queryItems = items
        return comps.url!
    }

    /// Decodificador JSON estándar de TMDB
    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .useDefaultKeys
        return d
    }()

    /// Trae una página de búsqueda de películas por `query`
    func fetchPage(query: String, page: Int = 1, language: String = "es-ES") -> AnyPublisher<PagedResponse<Movie>, Error> {
        let url = makeURL(
            path: "search/movie",
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "language", value: language)
            ]
        )

        return urlSession.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let http = output.response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: PagedResponse<Movie>.self, decoder: RestClient.decoder)
            .eraseToAnyPublisher()
    }

    /// Trae **todas** las páginas para una consulta dada (p.ej. "Avengers")
    func fetchAllMovies(query: String, language: String = "es-ES") -> AnyPublisher<[Movie], Error> {
        // 1) Obtener la primera página para saber totalPages
        return fetchPage(query: query, page: 1, language: language)
            .flatMap { firstPage -> AnyPublisher<[Movie], Error> in
                let totalPages = firstPage.totalPages
                guard totalPages > 1 else {
                    return Just(firstPage.results)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }

                // 2) Preparar publishers para páginas 2...totalPages
                let remaining = (2...totalPages).map { self.fetchPage(query: query, page: $0, language: language) }

                // 3) Encadenar todos, recolectar resultados y aplanar
                return Publishers.Sequence(sequence: remaining)
                    .flatMap { $0 }
                    .map(\.results)
                    .prepend(firstPage.results) // incluir la primera
                    .collect()
                    .map { $0.flatMap { $0 } } // [[Movie]] -> [Movie]
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
