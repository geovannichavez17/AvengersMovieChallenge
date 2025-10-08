//
//  JsonLoader.swift
//  AvengersMovieChallengeTests
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import Foundation

enum JsonLoader {
    static func jsonData(named name: String) -> Data {
        let bundle = Bundle(for: DummyBundleToken.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("File \(name).json no encontrado en el bundle de tests")
        }
        return (try? Data(contentsOf: url)) ?? Data()
    }

    private final class DummyBundleToken {}
}
