//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Alex on 11/4/21.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let homeViewModel: HomeViewModel = HomeViewModel(client: MovieClient(), categories: Category.defaultCategories)
    
    private var searchResultViewController: SearchResultViewController!
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.isLoading = { [weak self] in
            self?.tableView.reloadData()
        }
        
        homeViewModel.getMovies()
        title = "Alex Movies"
        
        searchResultViewController = FactoryViewController.createSearchResultViewController()
        searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
      
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = homeViewModel.searchText(searchText)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let category = homeViewModel.categories[indexPath.section]
        cell.moviesList = category.movies	
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: headerView.frame.size.width, height: 60))
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        label.text = homeViewModel.categories[section].name
        label.font = UIFont(name: "Charter", size: 28)
        
        headerView.addSubview(label)
        headerView.backgroundColor = .darkGray.withAlphaComponent(0.85)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultViewController.searchViewModel.filteredMovies = filteredMovies
        filterContentForSearchText(searchText)
    }
}

extension HomeViewController: CategoryTableViewCellDelegate {
    func collectionView(didSelectMovie movie: Movie) {
        let detail = FactoryViewController.createDetailViewController(withMovie: movie)
        show(detail, sender: nil)
    }
}
