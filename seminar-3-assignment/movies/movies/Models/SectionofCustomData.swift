//
//  SectionofCustomData.swift
//  movies
//
//  Created by grace kim  on 2022/10/25.
//

import Foundation
import UIKit
import RxDataSources

struct MoviesSection {
    var header : String
    var items : [Item]
    var uniqueId: String = "homeList"
}

extension MoviesSection: AnimatableSectionModelType {

    typealias Identity = String
    typealias Item = Movie
    
    init (original: MoviesSection, items: [Item]) {
        self = original
        self.items = items
    }
    var identity: String {
        return uniqueId
    }
}
