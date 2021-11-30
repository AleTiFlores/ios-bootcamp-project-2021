//
//  Array+Extension.swift
//  TheMovieDb
//
//  Created by Alex on 29/11/21.
//

import Foundation

extension Array where Element == Movie {
    func removeDuplicates() -> [Movie] {
        var result = [Movie]()
        for movie in self {
            if !result.contains(where: { $0.title == movie.title || $0.originalTitle == movie.originalTitle }) {
                result.append(movie)
            }
        }
        return result
    }
}
