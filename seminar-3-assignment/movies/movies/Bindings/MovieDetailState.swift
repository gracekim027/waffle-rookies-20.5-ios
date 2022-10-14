//
//  MovieDetailState.swift
//  movies
//
//  Created by grace kim  on 2022/10/14.
//

import Foundation

import UIKit
import Foundation

class MovieDetailState {
    
    var movie: Movie?
    var isLoading: Bool = false
    var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieViewModel.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(with id: Int) {
        self.movie = nil
        self.isLoading = true
        self.movieService.fetchMovie(id: id) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movie = response.self
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
