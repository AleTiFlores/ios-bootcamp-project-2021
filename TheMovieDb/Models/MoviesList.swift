//
//  MovieList.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.
//

import Foundation

struct MovieItem: Decodable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let url = try container.decode(String.self, forKey: .url)
        guard let id = url.matches("(\\d+)/$").first?.last else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        self.id = id
        self.name = try container.decode(String.self, forKey: .name)
    }
}

struct MoviesList: Decodable, Equatable{
    let results : [Movie]
}

extension String {
    func matches(_ pattern: String) -> [[String]] {
        let range = NSRange(self.startIndex..., in: self)
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let matches = regex.matches(in: self, options: [], range: range)

        var groups: [[String]] = []

        for match in matches {
            var subgroup: [String] = []
            // For each matched range, extract the capture group
            for index in 0..<match.numberOfRanges {
                let matchRange = match.range(at: index)
                // Extract the substring matching the capture group
                if let substringRange = Range(matchRange, in: self) {
                    let capture = String(self[substringRange])
                    subgroup.append(capture)
                }
            }
            groups.append(subgroup)
        }
        return groups
    }
}
