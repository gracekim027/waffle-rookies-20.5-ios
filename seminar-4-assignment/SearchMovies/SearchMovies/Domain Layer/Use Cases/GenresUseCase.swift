//
//  GenresUseCase.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/11/14.
//


import Foundation
import UIKit

final class GenresUseCase {
    
    private let dataRepository : SearchMoviesRepository
    
    var genres: [Genre]?
    var error : Error?
    
    init (dataRepository : SearchMoviesRepository){
        self.dataRepository = dataRepository
    }
    
    func loadGenres() {
        dataRepository.getGenreList() {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.genres = response.genres
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func findGenreTitle(with Id: Int) -> String{
        var name : String = "unknown"
        for genre in genres!{
            if (genre.id == Id){
                name = genre.name
            }
        }
        return name
    }
    
    func findGenreId(with title: String)->Int{
        var id : Int = 0
        for genre in genres!{
            if (genre.name == title){
                id = genre.id
            }
        }
        return id
    }
}

