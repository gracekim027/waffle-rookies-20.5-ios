//
//  CustomTabItem.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case home
    case favorite
}
 
extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController(item: .home)
        case .favorite:
            return FavoritesViewController(item: .favorite)
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "heart")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "heart.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}
