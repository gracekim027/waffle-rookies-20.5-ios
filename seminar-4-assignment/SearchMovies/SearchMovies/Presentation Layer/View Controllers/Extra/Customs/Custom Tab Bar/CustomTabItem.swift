//
//  CustomTabItem.swift
//  CustomTabBarExample
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case home
    case favorite
}
 
extension CustomTabItem {
    
    var viewController: UIViewController {
        
        let searchrepository = SearchMoviesRepository()
        let popularUsecase = MovieListUseCase(dataRepository: searchrepository)
        let topRatedUsecase = MovieListUseCase(dataRepository: searchrepository)
        let genreUsecase = GenresUseCase(dataRepository: searchrepository)
        
        
        let savedrepository = SaveMoviesRepository()
        let likedUsecase = LikedMovieUseCase(dataRepository: savedrepository)
        let likedVM = SavedMovieListViewModel(MoviesUseCase: likedUsecase)
        
        switch self {
        case .home:
            return HomeViewController(item: .home,
                                      popularUsecase: popularUsecase,
                                      topRatedUsecase: topRatedUsecase,
                                      likedVM: likedVM,
                                      genreList: genreUsecase)
        case .favorite:
            return FavoritesViewController(item: .favorite,
                                           likedVM: likedVM,
                                           genreList: genreUsecase)
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
