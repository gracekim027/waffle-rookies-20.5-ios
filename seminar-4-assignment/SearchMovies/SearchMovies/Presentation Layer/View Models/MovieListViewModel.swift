//
//  MovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//


import Foundation
import RxSwift

protocol MovieListViewModelProtocol {
    func fetchMovies(with endPoint : MovieListEndPoint)
   
}

///data needed when showing movie in list form
struct MovieListData {
    let title: String
    let posterPath: String?
    let voteAverage: Double
}


final class MovieListViewModel : MovieListViewModelProtocol {
    
    private let MoviesUseCase : MovieListUseCase
    
    init (MoviesUseCase : MovieListUseCase){
        self.MoviesUseCase = MoviesUseCase
    }
    
    //어차피 눌렀을 때 상세뷰 나와야해서 이러면 서칭해야함.
   /* var moviesListData : Observable<[MovieListData]> {
        return self.popularMoviesUseCase.MoviesObservable
            .map { Movie in
                return Movie.map {MovieListData(title: $0.title,
                                                posterPath: $0.posterPath,
                                                voteAverage: $0.voteAverage)
                }
            }
    }*/
    
    var movieData : Observable<[Movie]> {
        get {
            self.MoviesUseCase.MoviesObservable
        }
    }
    
    func fetchMovies(with endPoint: MovieListEndPoint) {
        self.MoviesUseCase.loadMovies(with: endPoint)
        
    }
    
    func appendMovies(with endPoint: MovieListEndPoint){
        self.MoviesUseCase.appendMovies(with: endPoint)
    }
    
}
