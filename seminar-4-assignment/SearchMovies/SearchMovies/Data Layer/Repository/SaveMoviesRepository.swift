//
//  SaveMoviesRepository.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//
import UIKit
import Foundation
import RxCocoa
import RxSwift

class SaveMoviesRepository: SaveMoviesDataRepositoryProtocol {
    
    private let defaults = UserDefaults.standard
    
    
    init(){}
    
    ///saves liked movies to  user defaults
    func saveLikedMovies(moviesToSave: [Movie]) {
        let movie_save = moviesToSave.map {
            [
                    "id" : $0.id,
                    "title": $0.title,
                    "posterPath": $0.posterPath ?? "",
                    "overview": $0.overview,
                    "voteAverage" : $0.voteAverage,
                    "releaseDate" : $0.releaseDate,
                    "liked" : $0.liked,
                    "genreIDs": $0.genreIDs
                
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(movie_save, forKey: "likedMovieList")
    }
    
    
    ///loads saved movies from user defaults
    func loadLikedMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        let userDefaults = UserDefaults.standard
        guard let movie_save = userDefaults.object(forKey: "likedMovieList") as? [[String: Any]] else {return}
        
        let savedMovies : [Movie] = movie_save.compactMap{
            guard let id = $0["id"] as? Int else { return nil}
            guard let title = $0["title"] as? String else {return nil}
            guard let posterPath = $0["posterPath"] as? String? else {return nil}
            guard let overview = $0["overview"] as? String else {return nil}
            guard let voteAverage = $0["voteAverage"] as? Double else {return nil}
            guard let releaseDate = $0["releaseDate"] as? String else {return nil}
            guard let liked = $0["liked"] as? Bool else {return nil}
            guard let genreIDs = $0["genreIDs"] as? [Int] else {return nil}
            
            return Movie(id: id, title: title, posterPath: posterPath, overview: overview, voteAverage: voteAverage, releaseDate: releaseDate, liked: liked, genreIDs: genreIDs)
        }
        completion(.success(savedMovies))
    }

}
