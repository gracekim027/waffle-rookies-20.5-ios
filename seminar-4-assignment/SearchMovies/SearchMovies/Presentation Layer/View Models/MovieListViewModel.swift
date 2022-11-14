//
//  MovieListViewModel.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation

protocol MovieListViewModelInput {
    func didSelect(at indexPath: IndexPath)
    func didSearchEndpoint(with movieListEndPoint : MovieListEndPoint)
}

protocol MovieListViewModelOutput {
    
}

protocol MovieListViewModelProtocol : MovieListViewModelInput, MovieListViewModelOutput {
    
}

final class MovieListViewModel : MovieListViewModelProtocol {
    
    //should be dependent to use case and have a use case (search movies use case)
    private let searchMoviesUseCase : SearchMoviesUseCase
    
    init (searchMoviesUseCase : SearchMoviesUseCase){
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    func didSelect(at indexPath: IndexPath) {
        <#code#>
    }
    
    func didSearchEndpoint(with movieListEndPoint: MovieListEndPoint) {
        <#code#>
    }
    
   
    
    
}
