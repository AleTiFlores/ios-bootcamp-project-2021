//
//  imageFetcher.swift
//  TheMovieDb
//
//  Created by Alex on 10/29/21.
//
import Foundation
import Kingfisher
import UIKit

struct ImageSetup {
 
    func setImage(imageView: UIImageView?){
        guard let url = URL(string: "https://cdn.pixabay.com/photo/2020/12/02/05/41/goku-5796332_1280.png") else { return }
        imageView?.kf.setImage(with: url)
    }
    
}
