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


protocol LikedMovieUseCaseProtocol {
    
    //loads movies from user defaults
    func loadLikedMovies()
    
    //saves movie to user defaults
    func saveLikedMovies()
    
    //adds movie to movie array
    func addLikedMovie(addedMovie : Movie)
    
    //deletes movie from movie array
    func deleteLikedMovie(deletedMovie: Movie)
}


final class LikedMovieUseCase : LikedMovieUseCaseProtocol {
    
    private let dataRepository : SaveMoviesRepository
    private let disposeBag = DisposeBag()
    
    init(dataRepository : SaveMoviesRepository){
        self.dataRepository = dataRepository
        self.loadLikedMovies()
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapLike"), object: nil, queue: nil, using: didTapLike)
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapNotLike"), object: nil, queue: nil, using: didTapNotLike)
    }
    
    
    private var movies = [Movie]() {
        didSet {
            self.getObserver()
            saveLikedMovies()
        }
    }
    
    func getObserver(){
        self.MoviesRelay.accept(movies)
    }
    
    var MoviesRelay = BehaviorRelay<[Movie]>(value: [])
    
    var MoviesObservable : Observable<[Movie]> {
        return self.MoviesRelay.asObservable()
    }
    
    func loadLikedMovies() {
        dataRepository.loadSavedData(){[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.movies = []
                self.movies = response
            case .failure(_):
                print("cannot load saved movies")
            }
        }
    }
    
    func saveLikedMovies() {
        self.dataRepository.saveData(moviesToSave: self.movies)
    }
    
    func addLikedMovie(addedMovie: Movie) {
        if !self.movies.contains( where: {$0.id == addedMovie.id} ){
            self.movies.append(addedMovie)
        }
    }
    
    func deleteLikedMovie(deletedMovie: Movie) {
        if movies.contains( where: {$0.id == deletedMovie.id} ){
            let index = movies.firstIndex(where: {$0.id == deletedMovie.id})!
            self.movies.remove(at: index)
        }
    }
    
    @objc func didTapLike(_ notification: Notification) -> Void{
        guard let movieToAdd = notification.userInfo!["movie"] as? Movie else {
            return
        }
        addLikedMovie(addedMovie: movieToAdd)
    }
    
    @objc func didTapNotLike(_ notification: Notification) -> Void{
        guard let movieToDelete = notification.userInfo!["movie"] as? Movie else {
            return
        }
        deleteLikedMovie(deletedMovie: movieToDelete)
    }
    
    
    func searchLikedMovie(searchMovie: Movie) -> Bool {
        if movies.contains( where: {$0.id == searchMovie.id} ){
            return true
        }else {
            return false
        }
    }
}

