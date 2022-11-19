//
//  LikedMovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/15.
//

import Foundation
import RxSwift

protocol SavedDataListViewModelProtocol {
    func loadData()
    func addToData(movie: Movie)
    func deleteLikedMovie(movie: Movie)
}

final class SavedMovieListViewModel : SavedDataListViewModelProtocol {
    
    private let LikedMoviesUseCase : LikedMovieUseCase
    
    init (MoviesUseCase : LikedMovieUseCase){
        self.LikedMoviesUseCase = MoviesUseCase
    }
    
    var movieData : Observable<[Movie]> {
        get {
            self.LikedMoviesUseCase.MoviesObservable
        }
    }
    
    func addToData(movie: Movie) {
        self.LikedMoviesUseCase.addLikedMovie(addedMovie: movie)
    }
    
    func deleteLikedMovie(movie: Movie) {
        self.LikedMoviesUseCase.deleteLikedMovie(deletedMovie: movie)
    }
    
    func loadData() {
        self.LikedMoviesUseCase.loadLikedMovies()
    }
    
    func searchData(movie: Movie) -> Bool{
        return self.LikedMoviesUseCase.searchLikedMovie(searchMovie: movie)
    }
    
}
