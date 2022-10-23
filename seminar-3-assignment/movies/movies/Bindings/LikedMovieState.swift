//
//  LikedMovieState.swift
//  movies
//
//  Created by grace kim  on 2022/10/18.
//

import Foundation
import RxSwift
import UIKit

class LikedMovieState {
    //todo list 참고하기
    static var shared = LikedMovieState()
    var LikedMovies:[Movie] = []
    private let defaults = UserDefaults.standard
    
    init(){
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapLike"), object: nil, queue: nil, using: didTapLike)
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapNotLike"), object: nil, queue: nil, using: didTapNotLike)
    }
    
    @objc func didTapLike(_ notification: Notification) -> Void{
        print("got movie to add")
        guard let movieToAdd = notification.userInfo!["movie"] as? Movie else {
            return
        }
        self.addMovie(newMovie: movieToAdd)
    }
    
    @objc func didTapNotLike(_ notification: Notification) -> Void{
        print("got movie to remove")
        guard let movieToDelete = notification.userInfo!["movie"] as? Movie else {
            return
        }
        self.removeMovie(movie_to_delete: movieToDelete)
    }
    
    func saveMovieList(){
        let movie_save = self.LikedMovies.map {
            [
                "id" : $0.id,
                "title": $0.title,
                "posterPath": $0.posterPath,
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
        LikedMovies.append(newMovie)
        self.saveMovieList()
    }
    
    func removeMovie(movie_to_delete: Movie){
        if LikedMovies.contains( where: {$0.id == movie_to_delete.id} ){
            let index = LikedMovies.firstIndex(where: {$0.id == movie_to_delete.id})!
            LikedMovies.remove(at: index)
            self.saveMovieList()
        }else{
            print("trying to unlike an unsaved movie")
        }
    }
    
    func loadMovieList(){
        let userDefaults = UserDefaults.standard
        guard let movie_save = userDefaults.object(forKey: "likedMovieList") as? [[String: Any]] else {return}
        self.LikedMovies = movie_save.compactMap{
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
    }
    
    func filterList(with genreName: String){
        
    }
    
}
