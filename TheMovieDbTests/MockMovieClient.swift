//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Alex on 09/12/20.
//

import XCTest
@testable import TheMovieDb

enum TestError: Error {
    case notFound
}

final class MockMovieClient: MovieApiProtocol {
    func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> Void) {
        do {
            guard let filepath = Bundle(for: HomeViewModelTests.self).path(forResource: HomeViewModelTests.resource, ofType: "json") else { return completion(nil, TestError.notFound) }
          
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filepath))
            let moviesList = try JSONDecoder().decode(MoviesList.self, from: jsonData)
            completion(moviesList, nil)
            
        } catch let jsonError {
            completion(nil, jsonError)
        }
        
    }
}
