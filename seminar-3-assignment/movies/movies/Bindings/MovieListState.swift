//
//  MovieListState.swift
//  movies
//
//  Created by grace kim  on 2022/10/11.
//

import UIKit
import Foundation
import RxSwift
import RxRelay

class MovieListState {
    
    let disposeBag = DisposeBag()
    static var shared = MovieListState()
    var movies : [Movie] = []
    let moviesObservable = BehaviorRelay<[Movie]>(value: [])
    var moviesObserver: Observable<[Movie]> {
        return moviesObservable.asObservable()
    }
    //question: where to put the page num?
    var error : Error?
    var page : Int = 1
    
    func getObservable() -> Observable<[Movie]>{
        return Observable<[Movie]>.of(self.movies)
    }
    
    func loadMovies(with endpoint: MovieListEndPoint) {
        //initial load movies (without pagination)
        //self.movies = nil
        RootViewModel.shared.fetchMovies(from: endpoint, pageNum: self.page) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.moviesObservable.accept(response.results)
            self.movies = response.results
        case .failure(let error):
            print("error in loading movies")
            self.error = error as NSError
        }
    }
    }
    
    
    func loadSearchMovies(with query: String) {
        self.movies = []
        RootViewModel.shared.searchMovie(from: query) { [weak self] (result) in
            //question: from and with diff?
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies = response.results
            print(self.movies[0].title)
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
        self.page = 1;
        self.movies = []
    }
}
