//
//  Movie.swift
//  TheMovieDb
//
//  Created by Alex on 11/3/21.
//

struct Movie: Codable {
    let title: String
    let overview: String
    let release_date: String
    let adult: Bool
    let backdrop_path: String?
    let id: Int
    let original_language: String
    let original_title: String
    let poster_path: String?
    let vote_count: Int
    let video: Bool
    let vote_average: Float
    let popularity: Float
    let media_type: String?
    
    enum Category: Decodable {
        case all
    }
}

extension Movie.Category: CaseIterable { }

extension Movie.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "All": self = .all
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .all: return "All"
    }
  }
}
