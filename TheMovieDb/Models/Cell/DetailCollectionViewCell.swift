//
//  DetailCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/18/21.
//

import UIKit
import Kingfisher

final class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var detailTextView: UITextView!
    
    func fillData(dataString: String) {
        
        if dataString.contains(".jpg") {
            detailImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w185\(dataString)"))
            detailTextView.isHidden = true
        } else {
            detailTextView.text = dataString
            detailImageView.isHidden = true
        }
    }
}
