//
//  FactoryViewController.swift
//  TheMovieDb
//
//  Created by Alex on 28/11/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    static let main = "Main"
}

enum FactoryViewController {
    
    static func createHomeViewController() -> HomeViewController {
        let controller: HomeViewController = createViewController()
        controller.homeViewModel = HomeViewModel(client: MovieClient(), categories: Category.defaultCategories)
        return controller
    }
    
    static func createSearchResultViewController() -> SearchResultViewController {
        let controller: SearchResultViewController = createViewController()
        controller.searchViewModel = SearchViewModel()
        return controller
    }
    
    static func createSwiftUIHostingController(withMovie movie: Movie) -> DetailViewSwiftUI {
        let controller = DetailViewSwiftUI(movie: movie)
        return controller
    }
    
    static func createViewController<T: UIViewController>(usingStoryboard storyboard: UIStoryboard = UIStoryboard(name: UIStoryboard.main, bundle: nil)) -> T {
        
        let identifier = String(describing: T.self)
        let instanceController = storyboard.instantiateViewController(withIdentifier: identifier) as? T
        
         guard let controller = instanceController else {
             preconditionFailure("Error.")
         }
        return controller
    }
}
