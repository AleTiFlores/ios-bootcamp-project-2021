//
//  MdbAPI.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.

import Foundation
import os.log

protocol MovieApiProtocol {
    func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> Void)
}

enum NetworkError: Error {
    case badURL
    case errorData
}

enum MovieDbEndPoints {
    static let trendingUrl: String = "/trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    static let nowPlayingUrl: String = "/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let popularUrl: String = "/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let topRatedUrl: String = "/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US"
    static let upcomingUrl: String = "/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/w185"
}

struct MovieClient: MovieApiProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    
    func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> Void) {
        
        guard let url = URL(string: baseURL + urlString) else { return }
        URLSession.shared.dataTask(with: url) { (sessionData, _, error) in
            
            if let errorFound = error {
                return completion(nil, errorFound)
            }
            
            guard let data = sessionData else { return }
            
            do {
                let moviesList = try JSONDecoder().decode(MoviesList.self, from: data)
                completion(moviesList, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }

        }.resume()
    }
}
