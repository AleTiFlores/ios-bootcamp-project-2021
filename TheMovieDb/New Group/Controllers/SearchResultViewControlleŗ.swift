//
//  SearchResultViewController.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit

final class SearchResultViewController: UIViewController {
 
    @IBOutlet weak var searchResultTableView: UITableView!

    var filteredMovies: [Movie] = [] {
        didSet {
            searchResultTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        cell.fillData(movie: filteredMovies[indexPath.row])

        return cell
    }
}
