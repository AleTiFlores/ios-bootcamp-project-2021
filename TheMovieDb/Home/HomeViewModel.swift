//
//  HomeViewModel.swift
//  TheMovieDb
//
//  Created by Alex on 29/11/21.
//

import Foundation
import os.log
import Combine
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    var isLoading: (() -> Void)? { get }
    var hasError: ((Error) -> Void)? { get }
    var categories: [Category] { get }
    var client: MovieApiProtocol { get }
    func getMovies()
}

struct Category: Hashable {
    let name: String
    let path: String
    var movies: [Movie]
    let color: UIColor
    
    static let defaultCategories = [Category(name: "Trending", path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customRed),
                                    Category(name: "Top Rated", path: MovieDbEndPoints.topRatedUrl, movies: [], color: UIColor.customGreen),
                                    Category(name: "Upcoming", path: MovieDbEndPoints.upcomingUrl, movies: [], color: UIColor.customBlue),
                                    Category(name: "Now Playing", path: MovieDbEndPoints.nowPlayingUrl, movies: [], color: UIColor.customPurple),
                                    Category(name: "Popular", path: MovieDbEndPoints.popularUrl, movies: [], color: UIColor.customGray)]
}

final class HomeViewModel: HomeViewModelDelegate {
    var hasError: ((Error) -> Void)?
    var isLoading: (() -> Void)?
    let client: MovieApiProtocol
    var categories: [Category]
    var cancellable: AnyCancellable?
    
    init(client: MovieApiProtocol, categories: [Category]) {
        self.client = client
        self.categories =  categories
    }
    
    func getMovies() {
        let group = DispatchGroup()
        
        for (index, category) in categories.enumerated() {
            
            group.enter()
            
            self.getData(dataUrl: category.path) { (result) in
                switch result {
                case .success(let movies):
                    
                    var newCategory = category
                    newCategory.movies = movies
                    
                    if let oldCategoryIndex = self.categories.firstIndex(where: { $0.name == category.name }) {
                        self.categories.remove(at: oldCategoryIndex)
                    }
                    self.categories.insert(newCategory, at: index)
                    
                case .failure(let failure):
                    self.hasError?(failure)
                    os_log(.error, "Unexpected error %@", [failure])
                }
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            self.isLoading?()
        }
    }
    
    func searchText(_ searchText: String) -> [Movie] {
        let movies = categories.flatMap { $0.movies }
        
        let filteredMovies = movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
        
        return filteredMovies.removeDuplicates()
        
    }
    
    private func getData(dataUrl: String, completion: @escaping(Result<[Movie], NetworkError>) -> Void) {
        client.performRequest(urlString: dataUrl) { (requestData, requestError) in
            if let requestError = requestError {
                os_log(.error, "Unexpected error %@", [requestError])
                completion(.failure(.badURL))
                return
            }
            guard let movies = requestData?.results else {
                completion(.failure(.errorData))
                return
            }
            completion(.success(movies))
        }
    }
}
