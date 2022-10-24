//
//  MovieService.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation

/*protocol MovieService {
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result <MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> ()  )
}*/

struct MovieViewModel{
    private let my_movie : Movie
    
    var id : Int {
        return my_movie.id
    }
    
    var title : String {
        return my_movie.title
    }
    
    var posterPath : String? {
        return my_movie.posterPath
    }
    
    var overview : String {
        return my_movie.overview
    }
    
    var voteAverage : Double {
        return my_movie.voteAverage
    }
    
    var releaseDate : String {
        return my_movie.releaseDate
    }
    
    var liked : Bool {
        return my_movie.liked
    }
    
    var genreIDs : [Int] {
        return my_movie.genreIDs
    }
    
    init(movie: Movie){
        self.my_movie = movie
    }
    
}

enum MovieListEndPoint: String{
    //popular, top rated
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String{
        switch self {
        case .apiError : return "Failed to fetch data"
        case .invalidEndPoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
