//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/5/21.
//

import UIKit
import Reusable
import Combine

final class CategoryCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var movie: Movie?
    
    func fillData(movie: Movie) {
        
        guard let posterPath = movie.posterPath else { return }
        let imageUrl = "https://image.tmdb.org/t/p/w185\(posterPath)"
        
        imageView.loadImage(urlString: imageUrl)
        titleLabel.text = movie.title
        self.movie = movie
    }
}
