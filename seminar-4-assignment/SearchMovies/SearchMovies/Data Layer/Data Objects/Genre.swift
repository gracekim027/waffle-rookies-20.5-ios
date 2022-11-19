//
//  Genre.swift
//  movies
//
//  Created by grace kim  on 2022/10/15.
//

import Foundation
import UIKit

struct Genre: Decodable {
    let id : Int
    let name : String
    
    private enum CodkingKeys: String, CodingKey {
        case id, name
    }
}

//genre response
struct GenreDict : Decodable {
    let genres : [Genre]
    
    private enum CodkingKeys: String, CodingKey {
        case genres
    }
    
}


