//
//  SearchResultViewController.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit

final class SearchResultViewController: UIViewController {
    @IBOutlet private weak var searchResultTableView: UITableView!

    var searchViewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        searchViewModel?.didSetFilteredMovies = {
            self.searchResultTableView.reloadData()
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel?.filteredMovies.count ?? 0
    }	
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let movie = searchViewModel?.filteredMovies[indexPath.row] else { return  cell }
        cell.fillData(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = searchViewModel?.filteredMovies[indexPath.row] else { return }
        let detail = FactoryViewController.createSwiftUIHostingController(withMovie: movie)
        show(detail, sender: nil)
    }
}
