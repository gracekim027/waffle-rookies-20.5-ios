//
//  GenreListState.swift
//  movies
//
//  Created by grace kim  on 2022/10/15.
//

import Foundation
import UIKit

class GenreListState {
    
    static var shared = GenreListState()
    var genres: [Genre]?
    var error : Error?
    
    func loadGenres() {
        MovieViewModel.shared.getGenreList() {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.genres = response.genres
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func findGenreTitle(with Id: Int) -> String{
        var name : String = "unknown"
        for genre in genres!{
            if (genre.id == Id){
                name = genre.name
            }
        }
        return name
    }
}
