//
//  SearchResultViewController.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit

final class SearchResultViewController: UIViewController {
    @IBOutlet private weak var searchResultTableView: UITableView!

    let searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        searchViewModel.didSetFilteredMovies = {
            self.searchResultTableView.reloadData()
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.filteredMovies.count
    }	
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillData(movie: searchViewModel.filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = FactoryViewController.createDetailViewController(withMovie: searchViewModel.filteredMovies[indexPath.row])
        show(detail, sender: nil)
    }
}
