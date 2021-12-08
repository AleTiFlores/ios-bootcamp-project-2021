//
//  MdbAPI.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.

import Foundation

struct MovieClient: MovieApiProtocol {
    
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
