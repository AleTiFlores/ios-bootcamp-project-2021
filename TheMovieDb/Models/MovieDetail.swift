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
    let title: String
    let year: String
    let rate: String
    var items: [String] = ["", "", "", "", ""]
    
    init(posterPath: String, overview: String, title: String, year: String, rate: String) {
        self.poster_path = posterPath
        self.items[0] = posterPath
        
        self.overview = overview
        self.items[1] = overview
        
        self.title = title
        self.items[2] = title
        
        self.year = year
        self.items[3] = year
        
        self.rate = rate
        self.items[4] = rate
    }
}
