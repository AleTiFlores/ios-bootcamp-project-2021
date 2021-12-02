//
//  MovieCombineClient.swift
//  TheMovieDb
//
//  Created by Alex on 30/11/21.
//

import Foundation
import Combine

final class MovieCombineClient: MovieApiProtocol {
    
    var subscriptions = [AnyCancellable]()
    
    func performRequest(urlString: String, completion: @escaping (MoviesList?, Error?) -> Void) {
        
        guard let url = URL(string: baseURL + urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                try JSONDecoder().decode(MoviesList.self, from: data)
            }
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { subscriberCompletion in
                if case .failure(let error) = subscriberCompletion {
                    completion(nil, error)
                }
            }, receiveValue: { moviesList in
                completion(moviesList, nil)
            })
            .store(in: &subscriptions)
        
    }
}
