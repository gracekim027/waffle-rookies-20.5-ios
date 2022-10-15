//
//  MovieListState.swift
//  movies
//
//  Created by grace kim  on 2022/10/11.
//

import UIKit
import Foundation

class MovieListState {
    
    static var shared = MovieListState()
    var movies: [Movie]?
    var error : Error?
    
    func loadMovies(with endpoint: MovieListEndPoint) {
        MovieViewModel.shared.fetchMovies(from: endpoint) { [weak self] (result) in
        guard let self = self else { return }
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
        MovieViewModel.shared.searchMovie(from: query) { [weak self] (result) in
            //question: from and with diff?
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies = response.results
            print(self.movies![0].title)
        case .failure(let error):
            self.error = error as NSError
        }
    }
    }
}
