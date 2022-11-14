//
//  MovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

//question: if there has to be a view model for each use case 이거 왜 하는거임?

import Foundation

protocol MovieListViewModelInput {
    func didSelect(at indexPath: IndexPath)
}

protocol MovieListViewModelOutput {
    
}

protocol MovieListViewModelProtocol : MovieListViewModelInput, MovieListViewModelOutput {
    
}

struct MovieListViewModelActions {
    let showMovieDetails: (Movie) -> Void
}

final class MovieListViewModel : MovieListViewModelProtocol {
    
    //should be dependent to use case and have a use case (search movies use case)
    private let popularMoviesUseCase : PopularMoviesUseCase
    private let actions : MovieListViewModelActions?
    
    private var movies:[Movie] = []
    
    init (popularMoviesUseCase : PopularMoviesUseCase, actions: MovieListViewModelActions){
        self.popularMoviesUseCase = popularMoviesUseCase
        self.actions = actions
    }
    
    func didSelect(at indexPath: IndexPath) {
        actions?.showMovieDetails(movies[indexPath.row])
    }
    
}
