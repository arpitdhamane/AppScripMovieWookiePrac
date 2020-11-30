//
//  XMLParser.swift
//  practicalencore
//
//  Created by Mac Mini on 12/11/20.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let movies: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let backdrop: String
    let cast: [String]
    let classification: Classification
    let director: Director
    let genres: [String]
    let id: String
    let imdbRating: Double
    let length, overview: String
    let poster: String
    let releasedOn, slug, title: String

    enum CodingKeys: String, CodingKey {
        case backdrop, cast, classification, director, genres, id
        case imdbRating = "imdb_rating"
        case length, overview, poster
        case releasedOn = "released_on"
        case slug, title
    }
}

enum Classification: String, Codable {
    case the13 = "13+"
    case the18 = "18+"
    case the7 = "7+"
}

enum Director: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Director.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Director"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}
