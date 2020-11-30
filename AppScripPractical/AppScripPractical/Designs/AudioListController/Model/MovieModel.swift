//
//  XMLParser.swift
//  practicalencore
//
//  Created by Mac Mini on 12/11/20.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Welcome {
    let movies: [Movie]
}

// MARK: - Movie
struct Movie {
    var backdrop: String = ""
    var classification: String = ""
    var genres: [String] = []
    var id: String = ""
    var imdbRating: Double = 0.0
    var length: String = ""
    var overview: String = ""
    var poster: String = ""
    var releasedOn: String = ""
    var slug: String = ""
    var title: String = ""

    enum CodingKeys: String, CodingKey {
        case backdrop, classification, director, genres, id
        case imdbRating = "imdb_rating"
        case length, overview, poster
        case releasedOn = "released_on"
        case slug, title
    }
}
