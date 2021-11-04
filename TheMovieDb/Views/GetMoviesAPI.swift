//
//  MdbAPI.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.

import Foundation

struct GetMoviesAPI {

    private let baseURL = "https://api.themoviedb.org/3/"
    // https://image.tmdb.org/t/p/w185/ for images

    public func performRequest(request: URLRequest) -> MoviesList? {
        var moviesList : MoviesList? = nil
        
        let session = URLSession.shared
        session.dataTask(with: request) { (sessionData, sessionResponse, error) in
            guard let response = sessionResponse,
                  let data = sessionData
            else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                moviesList = parseJSON(movieData: data)
            } catch {
                print(error)
            }
        }.resume()
        
        return moviesList
    }
    
    func parseJSON(movieData: Data) -> MoviesList? {
        let decoder = JSONDecoder()
        var decodedData : MoviesList? = nil
        
        do {
            decodedData = try decoder.decode(MoviesList.self, from: movieData)
            print(decodedData?.results[0].title)
        } catch {
            print(error)
        }
        return decodedData
    }
}
