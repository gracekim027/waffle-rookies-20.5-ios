//
//  DataManager.swift
//  movies
//
//  Created by grace kim  on 2022/10/18.
//

import UIKit
import Foundation

class DataManager {
    static let shared : DataManager = DataManager()
    var movieList : [Movie]?
    var movie : Movie?
    
    private init(){
    }
}
