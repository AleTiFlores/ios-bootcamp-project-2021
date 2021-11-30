//
//  Movie.swift
//  TheMovieDb
//
//  Created by Alex on 11/3/21.
//

struct Movie: Codable, Hashable {
    let title: String
    let overview: String
    let releaseDate: String
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let posterPath: String?
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
    let popularity: Float
    let mediaType: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case releaseDate = "release_date"
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case popularity
        case mediaType = "media_type"
    }
}
