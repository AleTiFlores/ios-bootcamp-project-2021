//
//  SearchViewModel.swift
//  TheMovieDb
//
//  Created by Alex on 29/11/21.
//

import Foundation

final class SearchViewModel {
    
    var didSetFilteredMovies: (() -> Void)?
    var filteredMovies: [Movie] = [] {
        didSet {
            didSetFilteredMovies?()
        }
    }
}
