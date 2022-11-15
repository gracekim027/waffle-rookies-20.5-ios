//
//  SearchMoviesUseCase.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SearchMoviesUseCaseProtocol {
    
    //loads movies with endpoint
    func loadMovies(with endpoint: MovieListEndPoint)
    
    //loads movies for pagination
    func appendMovies(with endPoint: MovieListEndPoint)
}


//기존 list state 이 use case 가 되는 것.
final class PopularMoviesUseCase : SearchMoviesUseCaseProtocol {
    
    private let dataRepository : SearchMoviesRepository
    private let disposeBag = DisposeBag()
    private var error : Error?
    private var page : Int = 1
    
    
    init(dataRepository : SearchMoviesRepository){
        self.dataRepository = dataRepository
    }
    
    private var movies = [Movie]() {
        didSet {
            self.getObserver()
        }
    }
    
    func getObserver(){
        self.MoviesRelay.accept(movies)
    }
    
    var MoviesRelay = BehaviorRelay<[Movie]>(value: [])
    
    var MoviesObservable : Observable<[Movie]> {
        return self.MoviesRelay.asObservable()
    }
    
    ///loads movies with endpoint
    func loadMovies(with endpoint: MovieListEndPoint) {
        dataRepository.fetchMovies(from: endpoint, pageNum: self.page) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies = []
            self.movies = response.results
        case .failure(let error):
            print(error.localizedDescription)
            self.error = error as NSError
        }
    }
    }
    
    ///loads movies for pagination
    func appendMovies(with endPoint: MovieListEndPoint){
        self.page = self.page + 1
        dataRepository.fetchMovies(from: endPoint, pageNum: self.page) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            self.movies += response.results
        case .failure(let error):
            print(error.localizedDescription)
            self.error = error as NSError
        }
    }
    }
    
    
    func initParams(){
        self.page = 1
        self.movies = []
    }
    
    
}
