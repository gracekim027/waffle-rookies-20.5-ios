//
//  Repository.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation
import RxSwift
import RxCocoa
#if canImport(FoundationNetworking)
import FoundationNetworking
import UIKit
//import XCTest
#endif

///wraps up database, networking, and data source handling logic
class SearchMoviesRepository : SearchMoviesDataRepositoryProtocol {
    //TODO: data repository should request from API service class
    
    private var semaphore = DispatchSemaphore (value: 0)
    private let apiKey = "f330b07acf479c98b184db47a4d2608b"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    var page : Int = 1
    var movies : [Movie] = []
    
    private init() {}
    
    //for when popular & top_rated
    func fetchMovies(from endpoint: MovieListEndPoint, pageNum: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ()){
        self.page = pageNum
        
        let URLString = "\(baseAPIURL)/movie/\(endpoint.rawValue)?api_key=\(apiKey)&language=en-US&page=\(page)"
        guard let url = URL(string: URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)  else {
            completion(.failure(.invalidEndPoint))
            print("url error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard error == nil else {
            print(String(describing: error))
            return }
        guard let data = data else {
            self.semaphore.signal()
            return
        }
        do {
            let results : MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            completion(.success(results))
            self.semaphore.signal()
            } catch {
            print(error.localizedDescription)
        }
        }
        task.resume()
        self.semaphore.wait()
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()){
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)?/api_key=\(apiKey)&language=en-US") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard error == nil else {
            print(String(describing: error))
            return }
        guard let data = data else {
            return
        }
        do {
            let result : Movie = try JSONDecoder().decode(Movie.self, from: data)
            DispatchQueue.main.async() {
            completion(.success(result))
                }
            
        } catch {
            print(url)
            print(String(describing: error))
        }
        }
        task.resume()
    }
    
      
    //for when search bar tapped
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()){
        guard let url = URL(string: "\(baseAPIURL)/search/movie?api_key=\(apiKey)&language=en-US&query=\(query)&page=\(page)&include_adult = false") else {
            completion(.failure(.invalidEndPoint))
            print("url error!")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard error == nil else {
            print("something went wrong")
            return }
        guard let data = data else {
            return
        }
        do {
            let result : MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            completion(.success(result))
            print(result.results[0].title)
        } catch {
            print(String(describing: error))
        }
        }
        task.resume()
    }
    
    func getGenreList(completion: @escaping (Result<GenreDict, MovieError>) -> ()){
        guard let url = URL(string:
                                "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US") else {
            completion(.failure(.invalidEndPoint))
            print("genre url error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard error == nil else {
            print("something went wrong in genre")
            return }
        guard let data = data else {
            self.semaphore.signal()
            return
        }
        do {
            //print("point 4")
            let result : GenreDict = try JSONDecoder().decode(GenreDict.self, from: data)
            completion(.success(result))
            self.semaphore.signal()
        } catch {
            print(String(describing: error))
        }
        }
        task.resume()
        self.semaphore.wait()
    }
}


