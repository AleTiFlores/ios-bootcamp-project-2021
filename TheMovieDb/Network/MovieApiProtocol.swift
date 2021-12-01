//
//  MovieApiProtocol.swift
//  TheMovieDb
//
//  Created by Alex on 30/11/21.
//

import Foundation

protocol MovieApiProtocol {
    var baseURL: String { get }
    func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> Void)
}

extension MovieApiProtocol {
    var baseURL: String { "https://api.themoviedb.org/3" }
}

enum NetworkError: Error {
    case badURL
    case errorData
}
