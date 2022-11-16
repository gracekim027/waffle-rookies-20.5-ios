//
//  MovieDetailViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/16.
//

import Foundation

final class MovieDetailViewModel {
    
    private var movie: Movie
    
    init(movie:Movie){
        self.movie = movie
    }
    
    func getMovie() -> Movie {
        return self.movie
    }
    
}
