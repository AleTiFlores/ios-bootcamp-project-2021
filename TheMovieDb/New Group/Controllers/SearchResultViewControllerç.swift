//
//  SearchResultViewController.swift
//  TheMovieDb
//
//  Created by Angel Trejo on 23/11/21.
//

import UIKit

final class SearchResultViewController: UIViewController {
 
    var isFiltering: Bool = false
    var filteredMoviesCount: Int = 0
    var moviesCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
      if isFiltering {
        return filteredMoviesCount
      }

      return moviesCount
    }
    
}
