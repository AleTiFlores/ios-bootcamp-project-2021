//
//  MovieDetail.swift
//  TheMovieDb
//
//  Created by Alex on 11/18/21.
//

import Foundation

struct MovieDetail: Codable {
    let poster_path: String?
    let overview: String
    let backdrop_path: String?
    var items: [String] = ["", "", ""]
    
    init(posterPath: String, overview: String, backgropPath: String) {
        self.poster_path = posterPath
        self.items[0] = posterPath
        self.overview = overview
        self.items[1] = overview
        self.backdrop_path = backgropPath
        self.items[2] = backgropPath
    }
}
