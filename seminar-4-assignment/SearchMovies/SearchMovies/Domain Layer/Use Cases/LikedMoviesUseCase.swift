//
//  LikedMoviesUseCase.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

final class LikedMovieUseCase {

    var LikedMovies = [Movie]() {
        didSet {
            self.getObserver()
            self.saveMovieList()
        }
    }
    
    func getObserver(){
        self.moviesObservable.accept(LikedMovies)
    }
    
    private let defaults = UserDefaults.standard
    
    var moviesObservable = BehaviorRelay<[Movie]>(value: [])
    
    var moviesObserver: Observable<[Movie]> {
        return moviesObservable.asObservable()
    }
    
    private init(){ }
    
    func saveMovieList(){
        let movie_save = self.LikedMovies.map {
            [
                    "id" : $0.id,
                    "title": $0.title,
                    "posterPath": $0.posterPath as Any,
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
    
    func addMovie(newMovie : Movie){
        if !LikedMovies.contains( where: {$0.id == newMovie.id} ){
            self.LikedMovies.append(newMovie)
        }
    }
    
    func removeMovie(movie_to_delete: Movie){
        if LikedMovies.contains( where: {$0.id == movie_to_delete.id} ){
            let index = LikedMovies.firstIndex(where: {$0.id == movie_to_delete.id})!
            self.LikedMovies.remove(at: index)
        }else{
            print("trying to unlike an unsaved movie")
        }
    }
    
    
    func loadMovieList(){
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
        self.moviesObservable.accept(savedMovies)
        LikedMovies = savedMovies
    }
}

