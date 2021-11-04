//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import Foundation
import UIKit
import Kingfisher

final class ViewController: UIViewController {
    
    @IBOutlet weak var trendingMovie: UIImageView?
    
    private let trendingUrl : String = "trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en%C2%AEion=US&page=1/su9WzL7lwUZPhjH6eZByAYFx2US.jpg"
    private let imagesBaseURL = "https://image.tmdb.org/t/p/w185/"
    
    private var moviesList: MoviesList? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesList()
    }
    
    private func getMoviesList() {
        let getMoviesAPI = GetMoviesAPI()
        
        getMoviesAPI.performRequest(urlString: trendingUrl) { (moviesList, requestError) in
            if let error = requestError {
                print("Found error: \(error)")
                return
            }
            
            self.moviesList = moviesList
            moviesList?.results.forEach { Movie in
                print(Movie.title)
            }
            
            self.refreshUI()
        }
    }
    
    private func refreshUI() {
        // Set the home banner random movie poster
        setRandomPoster()
    }
    
    private func setRandomPoster() {
        guard let moviesCount = moviesList?.results.count else { return }
        
        let randomIndex = Int.random(in: 0..<moviesCount)
        guard let posterPath = moviesList?.results[randomIndex].poster_path else { return }
        
        guard let imageUrl = URL(string: imagesBaseURL+posterPath) else { return }
        trendingMovie?.kf.setImage(with: imageUrl)
    }
}

