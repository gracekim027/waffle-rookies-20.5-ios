//
//  MovieStore.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

//search doesn't have filter with

import Foundation

class MovieViewModel: MovieService {
    
    private init() {}
    
    static let shared = MovieViewModel()
    private let apiKey = "f330b07acf479c98b184db47a4d2608b"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private var page : Int = 1
    var result : MovieResponse?
    
    //for when popular & top_rated
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)?/api_key=\(apiKey)&language=en-US&page=\(page)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    //for when detail view
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)?/api_key=\(apiKey)&language=en-US") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    //for when search bar tapped
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie?api_key=\(apiKey)&language=en-US&query=\(query)&page=\(page)&include_adult = false") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    //one page has 20 results --> show 40 initially
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
