//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/17/21.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let detailViewModel: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = detailViewModel.movie?.title
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let posterPath = detailViewModel.movie?.posterPath,
              let overview = detailViewModel.movie?.overview,
              let title = detailViewModel.movie?.title,
              let releaseDate = detailViewModel.movie?.releaseDate,
              let voteAverage = detailViewModel.movie?.voteAverage
        else { return  UITableViewCell() }
        let year = releaseDate.components(separatedBy: "-")[0]
        
        let movieDetail = MovieDetail(posterPath: posterPath, overview: overview, title: title, year: year, rate: "\(voteAverage)")
        cell.fillData(movie: movieDetail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = detailViewModel.movie?.title
        return label
    }
}
