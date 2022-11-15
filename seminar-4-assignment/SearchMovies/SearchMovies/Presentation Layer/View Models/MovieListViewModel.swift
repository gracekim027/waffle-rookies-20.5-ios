//
//  MovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

//question: if there has to be a view model for each use case 이거 왜 하는거임?

import Foundation
import RxCocoa
import RxSwift

protocol MovieListViewModelInput {
    func fetchMovies(with endPoint : MovieListEndPoint)
   
}

protocol MovieListViewModelOutput {
    
}

protocol MovieListViewModelProtocol : MovieListViewModelInput, MovieListViewModelOutput {
    
}

struct MovieListViewModelActions {
    let showMovieDetails: (Movie) -> Void
}

///data needed when showing movie in list form
struct MovieListData {
    let title: String
    let posterPath: String?
    let voteAverage: Double
}



final class MovieListViewModel : MovieListViewModelProtocol {
    
    private let popularMoviesUseCase : PopularMoviesUseCase
    
    
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
        return self.popularMoviesUseCase.MoviesObservable
    }
    
    init (popularMoviesUseCase : PopularMoviesUseCase){
        self.popularMoviesUseCase = popularMoviesUseCase
    }
    
    func fetchMovies(with endPoint: MovieListEndPoint) {
        self.popularMoviesUseCase.loadMovies(with: endPoint)
        
    }
    
    func appendMovies(with endPoint: MovieListEndPoint){
        self.popularMoviesUseCase.appendMovies(with: endPoint)
    }
    
    func didSelect(at indexPath: IndexPath) {
        //actions?.showMovieDetails(movies[indexPath.row])
    }
    
}
