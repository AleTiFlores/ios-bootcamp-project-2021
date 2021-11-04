//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

final class ViewController: UIViewController {
    
    let someForceCast = NSObject() as! Int

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=3f2d000acd208182b31eb1e5c2903ab8&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        let request = URLRequest(url: url)
        performRequest(request: request)
    }

    private func performRequest(request: URLRequest) {
        let session = URLSession.shared
        session.dataTask(with: request) { (sessionData, sessionResponse, error) in
            guard let response = sessionResponse,
                  let data = sessionData
            else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

