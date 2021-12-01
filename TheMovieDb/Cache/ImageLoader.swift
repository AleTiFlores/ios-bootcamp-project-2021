//
//  ImageLoader.swift
//  TheMovieDb
//
//  Created by Alex on 01/12/21.
//

import Foundation
import UIKit.UIImage
import Combine

final class ImageLoader {
    static let shared = ImageLoader()

    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    private init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { _ in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
