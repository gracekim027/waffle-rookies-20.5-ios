//
//  MoviesRepositoryProtocol.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation

///for loading movies from api
protocol GetDataRepositoryProtocol {
    func fetchItems(from endpoint: MovieListEndPoint, pageNum: Int, completion: @escaping (Result <MovieResponse, MovieError>) -> ())
    func fetchItem(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchItem(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> ()  )
}

///for loading movies from user defaults
protocol SaveDataRepositoryProtocol {
    func saveData(moviesToSave: [Movie])
    func loadSavedData(completion: @escaping (Result<[Movie], Error>) -> ())
}
