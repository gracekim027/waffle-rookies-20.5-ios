//
//  MovieListState.swift
//  movies
//
//  Created by grace kim  on 2022/10/11.
//

import UIKit
import Foundation

class MovieListState {
    
    var movies: [Movie]?
    var isLoading: Bool = false
    var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieViewModel.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndPoint) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func loadSearchMovies(with query: String) {
        self.movies = nil
        self.isLoading = true
        self.movieService.searchMovie(query: query) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
