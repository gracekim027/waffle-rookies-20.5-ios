//
//  TopRatedMoviesUseCase.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation
import RxCocoa
import RxSwift

final class TopRatedMoviesUseCase : SearchMoviesUseCaseProtocol {
    
    private let dataRepository : SearchMoviesRepository
    private let disposeBag = DisposeBag()
    
    var MoviesObservable = BehaviorRelay<[Movie]>(value: [])
    
    private var error : Error?
    private var page : Int = 1
    
    var movies = [Movie]() {
        didSet {
            self.getObserver()
        }
    }
    
    func getObserver(){
        self.MoviesObservable.accept(movies)
    }
    
    var moviesObserver: Observable<[Movie]> {
        return Observable.of(movies)
    }
    
    var moviesObservables: Observable<[Movie]>{
        return MoviesObservable.asObservable()
    }
    
    
    init(dataRepository : SearchMoviesRepository){
        self.dataRepository = dataRepository
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
