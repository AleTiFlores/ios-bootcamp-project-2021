//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//


import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var popularMovie: UIImageView!
    
    private var moviesList: MoviesList? = nil
    private let movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

    }

    private func setup() {
        getMoviesList()
    }
    
    private func getMoviesList() {
        var getMoviesAPI = GetMoviesAPI()
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1") else { return }
            let request = URLRequest(url: url)
        
        guard let moviesList = getMoviesAPI.performRequest(request: request) else { return }
        print(moviesList.results[1].title)
    }
    
}

