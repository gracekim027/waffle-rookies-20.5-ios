//
//  SearchMoviesViewController.swift
//  SearchMovies
//
//  Created by grace kim  on 2022/10/28.
//

import UIKit
import RxCocoa
import RxSwift

class SearchMoviesViewController: UIViewController, UICollectionViewDelegateFlowLayout {


    private let bag = DisposeBag()
    
    private var endPointState = SearchedMovieListState.shared
    
    
    var movieListView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var searchQuery : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name("searchBarTapped"), object: nil, queue: nil, using: didTapSearch)
        movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(movieListView)
        configureMovieList()
        self.movieListView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.bind()
    }
    
    @objc func didTapSearch(_ notification : Notification){
        self.searchQuery = notification.userInfo!["query"] as? String ?? "error"
        self.endPointState.loadSearchMovies(with: self.searchQuery!)
    }
    
    func bind(){
        
        movieListView.rx.setDelegate(self)
            .disposed(by: bag)

        movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
        
            // Put your code which should be executed with a delay here
            self.endPointState.moviesObservable
                .observe(on: MainScheduler.instance)
                .bind(to: self.movieListView.rx.items(cellIdentifier: "MoviesListCollectionViewCell", cellType: MoviesListCollectionViewCell.self )) { index, movie, cell in
                    cell.configureMovie(movie)
                    //print(movie.title)
                }
                .disposed(by: self.bag)
        
        movieListView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { movie in
            let VC = MovieDetailViewController(movie: movie)
            self.navigationController?.pushViewController(VC, animated: true)
            })
            .disposed(by: bag)
    }

    //pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y

        if offsetY > (self.movieListView.contentSize.height - 200 - scrollView.frame.size.height){
            self.endPointState.appendMovies(with: self.searchQuery!)
        }
    }
    
    func configureMovieList(){
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.showsVerticalScrollIndicator = false
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-24)/2, height: 250)
    }
}
