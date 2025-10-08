//
//  MockNetworkClient.swift
//  AvengersMovieChallengeTests
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import Foundation
import Combine
@testable import AvengersMovieChallenge

final class MockNetworkClient: NetworkClientType {
    
    enum MockError: Error { case missingJsonFile, forced(Error) }

    private var jsonsByPath: [String: Result<Data, Error>] = [:]
    private(set) var lastRequestedTarget: TargetType?

    init(jsonsByPath: [String: Result<Data, Error>] = [:]) {
        self.jsonsByPath = jsonsByPath
    }

    func setJson(forPath path: String, result: Result<Data, Error>) {
        jsonsByPath[path] = result
    }

    func request(_ target: TargetType) -> AnyPublisher<Data, Error> {
        lastRequestedTarget = target
        let key = target.path

        guard let result = jsonsByPath[key] else {
            return Fail(error: MockError.missingJsonFile).eraseToAnyPublisher()
        }

        switch result {
        case .success(let data):
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
