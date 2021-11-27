//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let movieSections = ["Trending",
                                 "Now Playing",
                                 "Popular",
                                 "Top Rated",
                                 "Upcoming"]
    private var movieList = [[Movie]]()
    private let categoriesUrl: [String] = ["\(MovieDbEndPoints.trendingUrl)",
                                           "\(MovieDbEndPoints.nowPlayingUrl)",
                                           "\(MovieDbEndPoints.popularUrl)",
                                           "\(MovieDbEndPoints.topRatedUrl)",
                                           "\(MovieDbEndPoints.upcomingUrl)"]
    private var searchResultViewController: SearchResultViewController?
    private var searchController: UISearchController!
    private var filteredMovies: [Movie] = []
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController
        
        tableView.delegate = self
        tableView.dataSource = self
        getMovies()
        title = "Alex Movies"
        searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func getMovies() {
        let downloadGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.gcd.dispatchGroup", attributes: .concurrent)
        
        for (_, url) in categoriesUrl.enumerated() {
            queue.async {
                downloadGroup.enter()
                self.getData(dataUrl: url) { (result) in
                    switch result {
                    case .success(let movies):
                        self.movieList.append(movies)
                        downloadGroup.leave()
                    case .failure(let fail):
                        debugPrint(fail)
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
            completion(.success(movies))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "ShowDetailSegue",
        let categoryCollectionViewCell = sender as? CategoryCollectionViewCell,
        let detailViewController = segue.destination as? DetailViewController
        else { return }
        detailViewController.movie = categoryCollectionViewCell.movie
    }
    
    func filterContentForSearchText(_ searchText: String, category: Movie.Category? = nil) {
        let movies = movieList.flatMap {$0}
        let filteredMovies = movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
        
        self.filteredMovies = filteredMovies.unique()
        print(self.filteredMovies)
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.moviesList = movieList[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor(red: 0.9, green: 0.49, blue: 0.89, alpha: 1)
        label.text = movieSections[section]
        return label
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultViewController?.filteredMovies = filteredMovies
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
