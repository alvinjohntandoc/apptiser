//
//  ItunesResponse.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import RealmSwift

class ItunesResponse: Object, Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case movies = "results"
    }
}


// MARK: - Result
class Movie: Object, Codable {
    @objc dynamic var artistName: String
    @objc dynamic var trackName: String
    @objc dynamic var country: String
    @objc dynamic var currency: String
    
    @objc dynamic var previewURL: String?
    
    @objc dynamic var artworkUrl30: String?
    @objc dynamic var artworkUrl60, artworkUrl100: String
    
    @objc dynamic var trackPrice: Double = 0
    @objc dynamic var longDescription: String?
    @objc dynamic var shortDescription: String?
    @objc dynamic var primaryGenreName: String?
    
    @objc dynamic var lastViewed: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case currency
        case country
        case previewURL
        case artworkUrl30
        case artworkUrl60, artworkUrl100
        case trackPrice
        case longDescription
        case shortDescription
        case primaryGenreName
    }
    
    required init() {
        self.artistName = ""
        self.trackName = ""
        self.currency = ""
        self.country = ""
        self.previewURL = ""
        self.artworkUrl30 = ""
        self.artworkUrl60 = ""
        self.artworkUrl100 = ""
        self.trackPrice = 0
        self.longDescription = ""
        self.shortDescription = ""
        self.primaryGenreName = ""
        self.lastViewed = 0
    }
}
