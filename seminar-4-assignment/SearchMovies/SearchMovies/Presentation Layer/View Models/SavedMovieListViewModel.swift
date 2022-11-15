//
//  LikedMovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/15.
//

import Foundation
import RxSwift

protocol SavedMovieListViewModelProtocol {
    func loadMovies()
    func addLikedMovie(movie: Movie)
    func deleteLikedMovie(movie: Movie)
}


final class SavedMovieListViewModel : SavedMovieListViewModelProtocol {
    
    private let LikedMoviesUseCase : LikedMovieUseCase
    
    init (MoviesUseCase : LikedMovieUseCase){
        self.LikedMoviesUseCase = MoviesUseCase
    }
    
    var movieData : Observable<[Movie]> {
        return self.LikedMoviesUseCase.MoviesObservable
    }
    
    func addLikedMovie(movie: Movie) {
        self.LikedMoviesUseCase.addLikedMovie(addedMovie: movie)
    }
    
    func deleteLikedMovie(movie: Movie) {
        self.LikedMoviesUseCase.deleteLikedMovie(deletedMovie: movie)
    }
    
    func loadMovies() {
        self.LikedMoviesUseCase.loadLikedMovies()
    }
    
}
