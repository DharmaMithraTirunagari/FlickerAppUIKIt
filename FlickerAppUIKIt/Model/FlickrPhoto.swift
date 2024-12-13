//
//  FlickrPhoto.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//

import Foundation

struct FlickrResponse: Codable {
    let items: [FlickrPhoto]
}

struct FlickrPhoto: Codable {
    let title: String
    let media: Media
    let description: String
    let author: String
    let published: String
}

struct Media: Codable {
    let m: String
}
