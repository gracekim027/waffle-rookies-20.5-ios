//
//  Movie.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation

struct MovieResponse : Decodable {
    let results : [Movie]
}

struct Movie : Decodable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    
    var posterURL: URL{
        //TODO: fix
        return URL(string: "https://image.tmdb.org/t/p/w185\(posterPath ?? "")")!
    }
}
