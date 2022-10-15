//
//  Movie.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation

struct MovieResponse : Decodable {
    let results : [Movie]
    
    private enum CodkingKeys: String, CodingKey {
        case results
    }
}

struct Movie : Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let liked = false
    
    private enum CodingKeys: String, CodingKey {
        case id, title = "original_title", posterPath = "poster_path", overview, voteAverage = "vote_average"
    }
}
    
