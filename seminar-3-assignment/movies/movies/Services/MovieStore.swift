//
//  MovieStore.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation

class MovieStore: MovieService {
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params: [
            "append_to_response" : "video, credits"
        ],completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params: [
            "language" : "en-US",
            "include_adult" : "false",
            "region" : "US",
            "query" : query
        ], completion: completion)
    }
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "f330b07acf479c98b184db47a4d2608b"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()){
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
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
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
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
