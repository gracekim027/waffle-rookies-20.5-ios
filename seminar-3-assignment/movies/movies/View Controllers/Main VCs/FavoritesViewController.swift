//
//  FavoritesViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
    
    private var likedMovieState = LikedMovieState.shared
   
    var titleLabel = UILabel()
    var categoryStackLabel = UILabel()
    var categoryStack = UIStackView()
    let headerLabel = UILabel()
    let profilePic = UIButton()
    var movieListView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    private let item : CustomTabItem
    
    init(item: CustomTabItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        self.view.backgroundColor = Styles.backgroundBlue
        likedMovieState.loadMovieList()
        super.viewDidLoad()
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(titleLabel)
        self.view.addSubview(categoryStackLabel)
        self.view.addSubview(categoryStack)
        configureSubLabels()
        
       movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       self.movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
       self.view.addSubview(movieListView)
        configureMovieListView()
        // Do any additional setup after loading the view.
    }
    
    func configureSubLabels(){
        
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
        
        self.categoryStack.translatesAutoresizingMaskIntoConstraints = false
        self.categoryStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.categoryStack.topAnchor.constraint(equalTo: self.categoryStackLabel.bottomAnchor, constant: 8).isActive = true
       self.categoryStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
       self.categoryStack.widthAnchor.constraint(equalToConstant: self.view.frame.width-48).isActive = true
       self.categoryStack.backgroundColor = .clear
    }
    
   
    
    func configureMovieListView(){
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.dataSource = self
        movieListView.showsVerticalScrollIndicator = false
        movieListView.delegate = self
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.categoryStack.bottomAnchor, constant: 20).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //TODO: add shadow,, scrolling looks hella ugly
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-24)/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovieState.LikedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: fix some time problem --> 좋아요 누르고 나서 reload 하는데 지체가 있음.
        let VC = MovieDetailViewController(movie: (likedMovieState.LikedMovies[indexPath.item]))
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as! MoviesListCollectionViewCell
        let movie = self.likedMovieState.LikedMovies[indexPath.row]
        cell.configureMovie(movie)
        return cell
    }
    
    

}
