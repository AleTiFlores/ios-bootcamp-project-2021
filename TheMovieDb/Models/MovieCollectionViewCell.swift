//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/5/21.
//

import Foundation
import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func fillData(movie: Movie) {
        imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster_path)"))
        titleLabel.text = movie.title
    }
}
