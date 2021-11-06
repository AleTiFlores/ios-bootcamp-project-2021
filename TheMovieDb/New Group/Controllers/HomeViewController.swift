//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.
//

import Foundation
import UIKit
import Kingfisher

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var randomTrendingMovie: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let trendingUrl: String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    private let nowPlayingUrl: String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    private let popularUrl: String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    private let topRatedUrl: String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    private let upcomingUrl: String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    
    private let imagesBaseURL = "https://image.tmdb.org/t/p/w185/"
    let movieSections = ["Trending" , "Now Playing", "Popular", "Top Rated", "Upcoming"]
    
    private var moviesList: MoviesList? = nil
    var trendingMovies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 240
        getTrendingMovies()
    }
    
    private func getTrendingMovies() {
        let getMoviesAPI = GetMoviesAPI()
        
        getMoviesAPI.performRequest(urlString: trendingUrl) { (trending, requestError) in
            if let error = requestError {
                print("Found error: \(error)")
                return
            }
            self.trendingMovies = trending?.results ?? []
            self.refreshUI()
        }
    }
    
    private func refreshUI() {
        // Set the home banner random movie poster
        setRandomPoster()
    }
    
    private func setRandomPoster() {
        let randomIndex = Int.random(in: 0..<trendingMovies.count)
        let posterPath = trendingMovies[randomIndex].poster_path
        guard let imageUrl = URL(string: imagesBaseURL+posterPath) else { return }
        randomTrendingMovie?.kf.setImage(with: imageUrl)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.moviesList = trendingMovies
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieSections[section]
    }
}
