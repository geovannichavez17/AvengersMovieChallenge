//
//  MoviesServiceTests.swift
//  AvengersMovieChallengeTests
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import XCTest
import Combine
@testable import AvengersMovieChallenge

private struct TestDependencies: MoviesServiceDependenciesType {
    let networkClient: NetworkClientType
    init(client: NetworkClientType) { self.networkClient = client }
}
final class MoviesServiceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func test_fetchMovies_returnsPagedResults() {
        // Arrange
        let mockClient = MockNetworkClient()
        mockClient.setJson(
            forPath: "/search/movie?query=batman&page=1",
            result: .success(JsonLoader.jsonData(named: "movies_search_page1"))
        )
        
        let deps = TestDependencies(client: mockClient)
        let sut = MoviesService(dependencies: deps)
        
        // Act
        let exp = expectation(description: "fetchMovies")
        var page: PagedResponse<Movie>?
        
        sut.fetchMovies(query: "batman", on: 1)
            .sink(receiveCompletion: {
                if case .failure(let error) = $0 {
                    XCTFail("Error: \(error)")
                }
            }, receiveValue: {
                page = $0; exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(page?.page, 1)
        XCTAssertEqual(page?.results.first?.id, 123)
        XCTAssertEqual(page?.totalPages, 10)
    }
    
    func test_getMovieDetail_decodesDetail() {
        // Arrange
        let mockClient = MockNetworkClient()
        mockClient.setJson(
            forPath: "/movie/123",
            result: .success(JsonLoader.jsonData(named: "movie_detail_123"))
        )
        
        let deps = TestDependencies(client: mockClient)
        let sut = MoviesService(dependencies: deps)
        
        // Act
        let exp = expectation(description: "movieDetail")
        var detail: MovieDetail?
        
        sut.getMovieDetail(id: 123)
            .sink(receiveCompletion: {
                if case .failure(let e) = $0 {
                    XCTFail("Error: \(e)")
                }
            }, receiveValue: {
                detail = $0; exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(detail?.title, "Batman Begins")
        XCTAssertEqual(detail?.backgroundImage, "/backdrop.jpg")
        XCTAssertEqual(detail?.voteAverage, 7.8)
    }
}
