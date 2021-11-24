//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/17/21.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else { return UITableViewCell() }
        
        guard let posterPath = movie?.poster_path,
              let overview = movie?.overview,
              let backdropPath = movie?.backdrop_path
        else { return  UITableViewCell() }
        
        let movieDetail = MovieDetail(posterPath: posterPath, overview: overview, backgropPath: backdropPath)
        
        cell.movieDetail = movieDetail
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = movie?.title
        return label
    }
}
