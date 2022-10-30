//
//  Movie.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation
import UIKit
import RxDataSources


struct MovieResponse : Decodable{
    let results : [Movie]
    
    private enum CodkingKeys: String, CodingKey {
        case results
    }
}

struct Movie : Decodable{
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let releaseDate : String
    var liked = false
    let genreIDs : [Int]
    
    private enum CodingKeys: String, CodingKey {
        case id, title = "original_title", posterPath = "poster_path", overview, voteAverage = "vote_average", releaseDate = "release_date", genreIDs = "genre_ids"
    }
}

extension Movie : IdentifiableType, Equatable{
    typealias Identity = Int
    var identity: Int {
        return id
    }

}

extension Movie : Hashable {
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}
    
