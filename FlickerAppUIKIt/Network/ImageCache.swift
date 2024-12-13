//
//  ImageCache.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}

    func loadImage(from urlString: String) async -> UIImage? {

        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: NSString(string: urlString)) 
                return image
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        return nil
    }
}
