//
//  AlbumModel.swift
//  TestiTunes
//
//  Created by Ragul kts on 27/04/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

// MARK: - ITunesAlbum
struct ITunesAlbum: Codable {
    var feed: Feed?
}

// MARK: - Feed
struct Feed: Codable {
    var title: String?
    var id: String?
    var author: Author?
    var links: [Link]?
    var copyright, country: String?
    var icon: String?
    var updated: String?
    var results: [Album]?
}

// MARK: - Author
struct Author: Codable {
    var name: String?
    var uri: String?
}

// MARK: - Link
struct Link: Codable {
    var linkSelf: String?
    var alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
}

// MARK: - Result
struct Album: Codable {
    var artistName, albumID, releaseDate, name: String?
    var kind: Kind?
    var copyright, artistID: String?
    var contentAdvisoryRating: ContentAdvisoryRating?
    var artistURL: String?
    var artworkUrl100: String?
    var genres: [Genre]?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case artistName, releaseDate, name, kind, copyright
        case albumID = "id"
        case artistID = "artistId"
        case contentAdvisoryRating
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
}

// MARK: - Genre
struct Genre: Codable {
    var genreID, name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum Kind: String, Codable {
    case album = "album"
}
