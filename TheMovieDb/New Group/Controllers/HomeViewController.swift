//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.
//

import Foundation
import UIKit
import Kingfisher

enum NetworkError: Error {
    case badURL
    case errorData
}

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var randomMovie: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    static let trendingUrl: String = "/trending/movie/day?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en&region=US&page=1"
    static let nowPlayingUrl: String = "/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let popularUrl: String = "/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let topRatedUrl: String = "/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US"
    static let upcomingUrl: String = "/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    static let imagesBaseURL = "https://api.themoviedb.org/3"
    private let movieSections = ["Trending" , "Now Playing", "Popular", "Top Rated", "Upcoming"]
    private var movieList = [[Movie]]()
    private let categoriesUrl: [String] = ["\(trendingUrl)",
                                           "\(nowPlayingUrl)",
                                           "\(popularUrl)",
                                           "\(topRatedUrl)",
                                           "\(upcomingUrl)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getMovies()
        print("Hi")
    }
    
    private func getMovies() {
        let downloadGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.gcd.dispatchGroup", attributes: .concurrent)
        
        for (index, url) in categoriesUrl.enumerated() {
            queue.async {
                downloadGroup.enter()
                self.getData(dataUrl: url) { (result) in
                    switch result {
                    case .success(let movies):
                        self.movieList.append(movies)
                        //self.movieList[index].append(contentsOf: movies)
                        downloadGroup.leave()
                    case .failure(_):
                        downloadGroup.leave()
                    }
                }
            }
        }
    
        downloadGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        downloadGroup.wait()
    }
    
    private func getData(dataUrl: String,
                         completion: @escaping(Result<[Movie], NetworkError>) -> Void) {
        let getMoviesAPI = GetMoviesAPI()
        getMoviesAPI.performRequest(urlString: dataUrl) { (requestData, requestError) in
            if let requestError = requestError {
                print("Error \(requestError)")
                completion(.failure(.badURL))
                return
            }
            guard let movies = requestData?.results else {
                completion(.failure(.errorData))
                return
            }
            print("success \(String(describing: requestData))")
            completion(.success(movies))
        }
    }
    
    private func refreshUI() {
        // Set the home banner random movie poster
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.moviesList = movieList[0]
        } else if indexPath.section == 1 {
            cell.moviesList = movieList[1]
        } else if indexPath.section == 2 {
            cell.moviesList = movieList[2]
        } else if indexPath.section == 3 {
            cell.moviesList = movieList[3]
        } else if indexPath.section == 4 {
            cell.moviesList = movieList[4]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieSections[section]
    }
}
