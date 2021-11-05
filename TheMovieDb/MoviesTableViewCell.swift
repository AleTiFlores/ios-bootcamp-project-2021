//
//  MoviesTableViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/5/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickShowMovieDetail(_ sender: UIButton) {
    }
}
