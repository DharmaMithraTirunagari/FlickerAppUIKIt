//
//  PhotoViewModel.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//

import Foundation

class PhotoViewModel {
    private var photos: [FlickrPhoto] = []
    var onPhotosUpdated: (() -> Void)? 

    var numberOfPhotos: Int {
        return photos.count
    }
    
    func photo(at index: Int) -> FlickrPhoto {
        return photos[index]
    }
    
    func fetchPhotos(searchTerm: String? = nil) {
        Task {
            do {
                let response: FlickrResponse = try await NetworkManager.shared.fetch(searchTerm: searchTerm)
                self.photos = response.items 
                DispatchQueue.main.async {
                    self.onPhotosUpdated?()
                }
            } catch {
                print("Error fetching photos: \(error)")
            }
        }
    }
}
