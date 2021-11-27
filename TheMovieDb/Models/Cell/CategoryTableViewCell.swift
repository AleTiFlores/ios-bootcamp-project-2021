//
//  MoviesTableViewCell.swift
//  TheMovieDb
//
//  Created by Alex on 11/5/21.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    
    var moviesList: [Movie]? {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let moviesList = moviesList else { return 0 }
        return moviesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell,
              let movieList = moviesList else {
            return UICollectionViewCell()
        }
        cell.fillData(movie: movieList[indexPath.row])
        
        return cell
    }
}
