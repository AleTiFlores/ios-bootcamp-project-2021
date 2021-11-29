//
//  SearchResultCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit
import Kingfisher

final class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet private weak var resultTitleLabel: UILabel!
    @IBOutlet private weak var resultImageView: UIImageView!
    
    var movie: Movie?
    
    func fillData(movie: Movie) {
        guard let posterPath = movie.poster_path else { return }
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath)")
        
        resultTitleLabel.text = movie.title
        resultImageView.kf.setImage(with: posterURL)
        self.movie = movie
    }
}
