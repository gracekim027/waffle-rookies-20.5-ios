//
//  extras.swift
//  news_search
//
//  Created by grace kim  on 2022/09/27.
//

import UIKit

struct styles {
    static let naver_green = UIColor(red: 2/255.0, green: 199/255.0, blue: 56/255.0, alpha: 1.0)
    static let title_blue = UIColor(red: 43/255.0, green: 102/255.0, blue: 188/255.0, alpha: 1.0)
    static let subtitle_gray1 = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
    static let subtitle_gray2 = UIColor(red: 143/255.0, green: 143/255.0, blue: 143/255.0, alpha: 1.0)
    
    var divider : UILabel = {
        var divider = UILabel()
        divider.layer.borderWidth = 1.0
        divider.layer.borderColor = UIColor(red: 0.886, green: 0.898, blue: 0.91, alpha: 1).cgColor
        divider.layer.backgroundColor = UIColor(red: 0.914, green: 0.925, blue: 0.937, alpha: 1).cgColor
        return divider
    }()


}
