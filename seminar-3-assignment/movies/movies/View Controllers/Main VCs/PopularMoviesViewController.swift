//
//  PopularMoviesViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/27.
//

import UIKit
import RxCocoa
import RxSwift

class PopularMoviesViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    private let bag = DisposeBag()
    
    private var endPoint = MovieListEndPoint.popular
    
    var endPointState = PopularMoviesListState.shared
    var movieListView: UICollectionView!
    let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        endPointState.loadMovies(with: endPoint)
        print(endPointState.movies[0].title)
        movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(movieListView)
        configureMovieList()
        self.movieListView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.bind()
    }
    
    func bind(){
        
        movieListView.rx.setDelegate(self)
            .disposed(by: bag)

        movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
        
            // Put your code which should be executed with a delay here
            self.endPointState.moviesObservables
                .observe(on: MainScheduler.instance)
                .bind(to: self.movieListView.rx.items(cellIdentifier: "MoviesListCollectionViewCell", cellType: MoviesListCollectionViewCell.self )) { index, movie, cell in
                    cell.configureMovie(movie)
                    print(movie.title)
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
            self.endPointState.appendMovies(with: self.endPoint)
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
