//
//  MoviesRepositoryProtocol.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation

///for loading movies from api
protocol SearchMoviesDataRepositoryProtocol {
    func fetchMovies(from endpoint: MovieListEndPoint, pageNum: Int, completion: @escaping (Result <MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> ()  )
}

///for loading movies from user defaults
protocol SaveMoviesDataRepositoryProtocol {
    
}
