//
//  UIImageView+Extension.swift
//  TheMovieDb
//
//  Created by Alex on 01/12/21.
//

import Foundation
import UIKit
import Combine

extension UIImageView {
    private static var subscriptions = [AnyCancellable]()
    
    func loadImage(urlString: String) {
        
        guard let imageURL = URL(string: urlString) else { return }
        ImageLoader.shared.loadImage(from: imageURL).sink { image in
            self.image = image
        }.store(in: &UIImageView.subscriptions)
    }
}
