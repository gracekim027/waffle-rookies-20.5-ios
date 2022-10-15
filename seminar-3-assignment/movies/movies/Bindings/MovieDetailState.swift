//
//  MovieDetailState.swift
//  movies
//
//  Created by grace kim  on 2022/10/14.
//

import Foundation

import UIKit

class MovieDetailState {
    
    var movie: Movie?
    var isLoading: Bool = false
    var error: NSError?

    func loadMovies(with id: Int) {
        self.movie = nil
        //MovieViewModel.shared.fetchMovie
    }
}
