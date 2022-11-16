//
//  FavoritesViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit
import RxCocoa
import RxSwift

class FavoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout{
    
    private let bag = DisposeBag()
    
    private let likedVM : SavedMovieListViewModel
    private let genreList : GenresUseCase

    private var titleLabel = UILabel()
    private var categoryStackLabel = UILabel()
    
    private var headerLabel = UILabel()
    private var profilePic = UIButton()
    private var movieListView: UICollectionView!
    private var genreListView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    private var layout2 = UICollectionViewFlowLayout()
    private var item : CustomTabItem
    
    init(item: CustomTabItem,
         likedVM: SavedMovieListViewModel,
         genreList: GenresUseCase) {
        self.item = item
        self.likedVM = likedVM
        self.genreList = genreList
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Styles.backgroundBlue
        self.bind()
        addSubviews()
        configureSubviews()
    }
    
    
    private func addSubviews(){
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(titleLabel)
        self.view.addSubview(categoryStackLabel)
        self.view.addSubview(movieListView)
        self.view.addSubview(genreListView)
    }
    
    private func bind(){
        
        //-----cell register-----
        movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
         
         genreListView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
         self.genreListView.register(MovieGenreCollectionViewCell.self, forCellWithReuseIdentifier: "MovieGenreCollectionViewCell")

        //-----binding for genre collection view----
        genreListView.rx.setDelegate(self)
            .disposed(by: bag)
        
        let genreObservable = Observable.of(self.genresToSave)
        genreObservable
            .observe(on: MainScheduler.instance)
            .bind(to: genreListView.rx.items(cellIdentifier: "MovieGenreCollectionViewCell", cellType: MovieGenreCollectionViewCell.self))
        { title, emoji, cell in
            cell.configureGenre(title: emoji[0], emoji: emoji[1])
            cell.layer.cornerRadius = 15
            if (emoji[0] == "all"){
                cell.isSelected = true
            }
        }
        .disposed(by: bag)
        
        
        //-----binding for liked movie collection view----
        movieListView.rx.setDelegate(self)
            .disposed(by: bag)
        
        self.likedVM.movieData
            .observe(on: MainScheduler.instance)
            .bind(to: movieListView.rx.items(cellIdentifier: "MoviesListCollectionViewCell", cellType: MoviesListCollectionViewCell.self )) { index, movie, cell in
                cell.configureMovie(movie)
            }
            .disposed(by: bag)
        
        self.movieListView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { movie in
            let VC = MovieDetailViewController(movie: movie,
                                               likedVM: self.likedVM,
                                               genreList: self.genreList)
            self.navigationController?.pushViewController(VC, animated: true)
            })
            .disposed(by: bag)
    }
    
    private func configureSubviews(){
        configureSubLabels()
        configureGenreListView()
        configureMovieListView()
    }
    
    
    //---configure subviews-----
    private func configureSubLabels(){
        self.headerLabel.text = "Welcome User! 👋"
        self.headerLabel.textColor = Styles.darkGrey
        self.headerLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        
        self.profilePic.setImage(UIImage(named: "profile"), for: .normal)
        self.profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.profilePic.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.profilePic.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true

        self.titleLabel.text = "Your Favorites"
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        
        self.categoryStackLabel.text = "Categories"
        self.categoryStackLabel.textColor = .white
        self.categoryStackLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.categoryStackLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryStackLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.categoryStackLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 25).isActive = true
    }
    
   
    private func configureGenreListView(){
        layout2.scrollDirection = .horizontal
        genreListView.setCollectionViewLayout(layout2, animated: true)
        genreListView.showsHorizontalScrollIndicator = false
        genreListView.backgroundColor = .clear
        genreListView.translatesAutoresizingMaskIntoConstraints = false
        genreListView.topAnchor.constraint(equalTo: self.categoryStackLabel.bottomAnchor, constant: 10).isActive = true
        genreListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        genreListView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        genreListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        genreListView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    
    private func configureMovieListView(){
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.showsVerticalScrollIndicator = false
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.genreListView.bottomAnchor, constant: 20).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.movieListView{
        return CGSize(width: (collectionView.frame.width-24)/2, height: 280)
        }else {
            return CGSize(width: 68.0, height: 72.0)
        }
    }
    
    private let genresToSave =
    [
    ["all", "☺️"],
    ["action","😮‍💨"],
    ["comedy", "😝"],
    ["drama", "😢"],
    ["horror",  "😱"],
    ["mystery", "🤫"],
    ["romance", "😘"],
    ["sci-fi", "🤯"],
    ["history", "🤠"]
    ]
}
