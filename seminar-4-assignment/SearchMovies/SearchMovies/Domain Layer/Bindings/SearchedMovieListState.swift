//
//  SearchedMovieState.swift
//  movies
//
//  Created by grace kim  on 2022/10/27.
//

import Foundation

import Foundation
import RxSwift
import UIKit
import RxCocoa

class SearchedMovieListState {
   
    var error : Error?
    var page : Int = 1
    
    var searchedMovies = [Movie]() {
        didSet {
            self.getObserver()
        }
    }
    
    func getObserver(){
        self.moviesObservable.accept(searchedMovies)
    }
    
    static var shared = SearchedMovieListState()
    
    
    var moviesObservable = BehaviorRelay<[Movie]>(value: [])
    
    var moviesObserver: Observable<[Movie]> {
        return moviesObservable.asObservable()
    }
    
    init(){
       
    }
    
    func loadSearchMovies(with query: String) {
        //self.movies = []
        RootViewModel.shared.searchMovie(from: query) { [weak self] (result) in
            //question: from and with diff?
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.searchedMovies = response.results
        case .failure(let error):
            self.error = error as NSError
        }
    }
    }
   
    func appendMovies(with query: String){
        self.page = self.page + 1
        RootViewModel.shared.searchMovie(from: query) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.searchedMovies += response.results
        case .failure(let error):
            print("error in loading movies")
            self.error = error as NSError
        }
    }
    }
    
    func initParams(){
        self.page = 1
        self.searchedMovies = []
    }
    
    
}

