//
//  MovieDbEndPoints.swift
//  TheMovieDb
//
//  Created by Alex on 30/11/21.
//

import Foundation

enum MovieDbEndPoints {
    static let trendingUrl: String = "/trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    static let nowPlayingUrl: String = "/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let popularUrl: String = "/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let topRatedUrl: String = "/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US"
    static let upcomingUrl: String = "/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/w185"
}
