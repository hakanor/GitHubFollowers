//
//  ImageLoader.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 17.03.2024.
//

import UIKit.UIImage

final class ImageLoader {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageLoader()
    
    func insert(urlString: String, image: UIImage?) {
        guard let image = image else { return }
        let cacheKey = NSString(string: urlString)
        self.imageCache.setObject(image, forKey: cacheKey)
    }
    
    func value(cacheKey: String) -> UIImage? {
        let cacheKey = NSString(string: cacheKey)
        
        guard let image = imageCache.object(forKey: cacheKey) else {
            return nil
        }
        return image
    }
    
    func removeValue(urlString: String) {
        let cacheKey = NSString(string: urlString)
        imageCache.removeObject(forKey: cacheKey)
    }
}
