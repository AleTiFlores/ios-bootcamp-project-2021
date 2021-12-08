//
//  SearchResultCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit
import Reusable

final class SearchResultTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private weak var resultTitleLabel: UILabel!
    @IBOutlet private weak var resultImageView: UIImageView!
    
    var movie: Movie?
    
    func fillData(movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        
        resultTitleLabel.text = movie.title
        resultImageView.loadImage(urlString: "https://image.tmdb.org/t/p/w185\(posterPath)")
        self.movie = movie
    }
}
