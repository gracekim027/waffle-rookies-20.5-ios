//
//  TopRatedMoviesListState.swift
//  movies
//
//  Created by grace kim  on 2022/10/27.
//

import Foundation

import UIKit
import Foundation
import RxSwift
import RxRelay

class TopRatedMoviesListState {
    
    let disposeBag = DisposeBag()
    static var shared = TopRatedMoviesListState()
    var movies : [Movie] = []
    
    var MoviesObservable = BehaviorRelay<[Movie]>(value: [])
    
    var moviesObserver: Observable<[Movie]> {
        return Observable.of(movies)
    }
    
    var moviesObservables: Observable<[Movie]>{
        return MoviesObservable.asObservable()
    }
    
    var error : Error?
    var page : Int = 1
    
    
    func loadMovies(with endpoint: MovieListEndPoint) {
       
        //initial load movies (without pagination)
        RootViewModel.shared.fetchMovies(from: endpoint, pageNum: self.page) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies = []
            self.movies = response.results
        case .failure(let error):
            //print("error in loading movies")
            self.error = error as NSError
        }
    }
 }

    
    func loadSearchMovies(with query: String) {
        //self.movies = []
        RootViewModel.shared.searchMovie(from: query) { [weak self] (result) in
            //question: from and with diff?
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies = response.results
        case .failure(let error):
            self.error = error as NSError
        }
    }
    }
    
    func appendMovies(with endPoint: MovieListEndPoint){
        self.page = self.page + 1
        RootViewModel.shared.fetchMovies(from: endPoint, pageNum: self.page) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies += response.results
        case .failure(let error):
            print("error in loading movies")
            self.error = error as NSError
        }
    }
    }
    
    func initParams(){
        self.page = 1
        self.movies = []
    }
}
