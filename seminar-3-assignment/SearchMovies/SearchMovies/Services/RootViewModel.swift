//
//  MovieStore.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.


import Foundation
import RxSwift
import RxCocoa
#if canImport(FoundationNetworking)
import FoundationNetworking
import UIKit
//import XCTest
#endif

var semaphore = DispatchSemaphore (value: 0)

class RootViewModel {
    
    private init() {}
    
    static let shared = RootViewModel()
    private let apiKey = "f330b07acf479c98b184db47a4d2608b"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    var page : Int = 1
    var movies : [Movie] = []
    
    
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
            print("something went wrong")
            return }
        guard let data = data else {
            semaphore.signal()
            return
        }
        do {
            //print("point 3")
            let results : MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            //print(results.results[0].title) --> 여기까지됨.
            completion(.success(results))
            semaphore.signal()
            } catch {
            print(error.localizedDescription)
        }
        }
        task.resume()
        semaphore.wait()
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()){
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)?/api_key=\(apiKey)&language=en-US") else {
            completion(.failure(.invalidEndPoint))
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
            let result : Movie = try JSONDecoder().decode(Movie.self, from: data)
            DispatchQueue.main.async() {
            completion(.success(result))
                }
           
            //print(result.title)
            
        } catch {
            print(url)
            print(String(describing: error))
        }
        }
        task.resume()
    }
    
      
    //for when search bar tapped
    func searchMovie(from query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()){
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
            semaphore.signal()
            return
        }
        do {
            //print("point 4")
            let result : GenreDict = try JSONDecoder().decode(GenreDict.self, from: data)
            completion(.success(result))
            semaphore.signal()
        } catch {
            print(String(describing: error))
        }
        }
        task.resume()
        semaphore.wait()
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, completion: @escaping (Result<D, MovieError>) -> ()){
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil {
                self.executeCompletionHandlerMainThread(wth: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerMainThread(wth: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerMainThread(wth: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(D.self, from: data)
                self.executeCompletionHandlerMainThread(wth: .success(decodedResponse), completion: completion)
            }catch {
                self.executeCompletionHandlerMainThread(wth: .failure(.serializationError), completion: completion)
            }
        }
    }
    
    private func executeCompletionHandlerMainThread<D: Decodable>(wth result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()){
        DispatchQueue.main.async {
            completion(result)
        }
    }

}
