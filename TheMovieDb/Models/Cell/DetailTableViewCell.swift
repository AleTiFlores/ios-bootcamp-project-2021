//
//  DetailTableViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/18/21.
//

import UIKit
import Kingfisher
import Reusable

final class DetailTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var headerImageView: UIImageView!
    
    func fillData(movie: MovieDetail?) {
        descriptionLabel.text = movie?.overview
        if let poster_path = movie?.poster_path,
            let url = URL(string: "\(MovieDbEndPoints.imagesBaseURL)\(poster_path)") {
            headerImageView.kf.setImage(with: url)
        }
    }
}
