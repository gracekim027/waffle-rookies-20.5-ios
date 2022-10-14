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
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let runtime: Int?
    
    //question: is it okay to have keys that json does not give?
    
    //var liked: Bool = false
    
    //var posterURL: URL{
        //return URL(string: "https://image.tmdb.org/t/p/w185\(posterPath ?? "")")!
    //}
}
