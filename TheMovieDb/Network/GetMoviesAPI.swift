//
//  MdbAPI.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.

import Foundation

struct GetMoviesAPI {

    private let baseURL = "https://api.themoviedb.org/3/"

    public func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> ()) {
        
        guard let url = URL(string: baseURL + urlString) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (sessionData, sessionResponse, error) in
            
            if let errorFound = error {
                completion(nil, errorFound)
                return
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
