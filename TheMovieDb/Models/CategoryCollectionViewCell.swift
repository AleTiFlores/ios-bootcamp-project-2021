//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/5/21.
//

import UIKit
import Kingfisher

final class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func fillData(movie: Movie) {
        guard let posterPath = movie.poster_path else { return }
        let imageUrl = "https://image.tmdb.org/t/p/w185\(posterPath)"
        imageView.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = movie.title
    }
}
