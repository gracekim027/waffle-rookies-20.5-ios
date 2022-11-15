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
    private let movieListViewModel : MovieListViewModel
    private var endPoint = MovieListEndPoint.popular
    
    init(movieListViewModel : MovieListViewModel){
        self.movieListViewModel = movieListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var movieListView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListViewModel.fetchMovies(with: endPoint)
        movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(movieListView)
        configureMovieList()
        self.bind()
    }
    
    private func bind(){
        
        movieListView.rx.setDelegate(self)
            .disposed(by: bag)

        movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
        
        self.movieListViewModel.movieData
            .observe(on: MainScheduler.instance)
            .bind(to: self.movieListView.rx.items(cellIdentifier: "MoviesListCollectionViewCell", cellType: MoviesListCollectionViewCell.self )) { index, movie, cell in
                    cell.configureMovie(movie)
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
            self.movieListViewModel.appendMovies(with: self.endPoint)
        }
    }
}


///functions related to applying design
extension PopularMoviesViewController {
    
    private func configureMovieList(){
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.showsVerticalScrollIndicator = false
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        movieListView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-24)/2, height: 250)
    }
    
   
}
