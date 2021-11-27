//
//  DetailTableViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/18/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    var movieDetail: MovieDetail? {
        didSet {
            detailCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
}

extension DetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let detailItems = movieDetail?.items.count else { return 0 }
        return detailItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell
        else { return UICollectionViewCell() }
        
        guard let detailItems = movieDetail?.items else { return UICollectionViewCell() }
        
        cell.fillData(dataString: detailItems[indexPath.row])

        return cell
    }
}
