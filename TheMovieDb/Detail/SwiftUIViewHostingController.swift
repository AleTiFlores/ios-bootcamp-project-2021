//
//  SwiftUIViewHostingController.swift
//  TheMovieDb
//
//  Created by Alex on 30/11/21.
//

import Foundation
import SwiftUI

class DetailViewSwiftUI: UIViewController {
    
    private let movie: Movie
    
    lazy var container: UIHostingController<DetailView> = {
        let container = UIHostingController(rootView: DetailView(poster: movie.posterPath, description: movie.overview))
      return container
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(container)
        view.addSubview(container.view)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        container.view.translatesAutoresizingMaskIntoConstraints = false
        container.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        container.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
                
class SwiftUIViewHostingController: UIHostingController<DetailView> {
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder, rootView: DetailView(poster: "opPoster", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
       }
}
