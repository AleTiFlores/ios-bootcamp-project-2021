//
//  SearchResultViewController.swift
//  TheMovieDb
//
//  Created by Alex on 23/11/21.
//

import UIKit

final class SearchResultViewController: UIViewController {
    @IBOutlet private weak var searchResultTableView: UITableView!

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
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillData(movie: filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Search result selected, \(indexPath)")
        let detail = FactoryViewController.createDetailViewController(withMovie: filteredMovies[indexPath.row])
        show(detail, sender: nil)
    }
}
