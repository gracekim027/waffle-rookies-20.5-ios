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
    
    let headerLabel = UILabel()
    let profilePic = UIButton()
    var movieListView: UICollectionView!
    var genreListView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    let layout2 = UICollectionViewFlowLayout()
    private let item : CustomTabItem
    
    init(item: CustomTabItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapLike"), object: nil, queue: nil, using: didTapLike)
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapNotLike"), object: nil, queue: nil, using: didTapLike)
        NotificationCenter.default.addObserver(forName: Notification.Name("reloadFilteredCells"), object: nil, queue: nil, using: reloadFilteredData)
        self.view.backgroundColor = Styles.backgroundBlue
        likedMovieState.loadMovieList()
        super.viewDidLoad()
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(titleLabel)
        self.view.addSubview(categoryStackLabel)
        configureSubLabels()
        
       movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       self.movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
        
        genreListView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        self.genreListView.register(MovieGenreCollectionViewCell.self, forCellWithReuseIdentifier: "MovieGenreCollectionViewCell")
        
       self.view.addSubview(movieListView)
        self.view.addSubview(genreListView)
        configureGenreListView()
        configureMovieListView()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapLike(_ notification: Notification) -> Void{
      self.movieListView.reloadData()
    }
    
    @objc func reloadFilteredData(_ notification: Notification) -> Void{
        self.movieListView.reloadData()
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
    }
    
   
    
    func configureGenreListView(){
        layout2.scrollDirection = .horizontal
        genreListView.setCollectionViewLayout(layout2, animated: true)
        genreListView.dataSource = self
        genreListView.showsHorizontalScrollIndicator = false
        genreListView.delegate = self
        genreListView.backgroundColor = .clear
        genreListView.translatesAutoresizingMaskIntoConstraints = false
        genreListView.topAnchor.constraint(equalTo: self.categoryStackLabel.bottomAnchor, constant: 10).isActive = true
        genreListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        genreListView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        genreListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //TODO: how to add padding?
        genreListView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    func configureMovieListView(){
        
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.dataSource = self
        movieListView.showsVerticalScrollIndicator = false
        movieListView.delegate = self
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.genreListView.bottomAnchor, constant: 20).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //TODO: add shadow,, scrolling looks hella ugly
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.movieListView{
        return CGSize(width: (collectionView.frame.width-24)/2, height: 250)
        }else {
            return CGSize(width: 48.0, height: 72.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.movieListView{
        return likedMovieState.LikedMovies.count
        }else{
            return genresToSave.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: fix some time problem --> 좋아요 누르고 나서 reload 하는데 지체가 있음.
        //TODO: dispatch queue add time delay
        if collectionView == self.movieListView{
        let movie = likedMovieState.LikedMovies[indexPath.item]
        let VC = MovieDetailViewController(movie: movie)
        self.navigationController?.pushViewController(VC, animated: true)
        }else{
            let genre = genresToSave[indexPath.item][0]
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieListView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as! MoviesListCollectionViewCell
        let movie = self.likedMovieState.LikedMovies[indexPath.row]
        cell.configureMovie(movie)
        return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGenreCollectionViewCell", for: indexPath) as! MovieGenreCollectionViewCell
            
            let title  = self.genresToSave[indexPath.row][0]
            let emoji = self.genresToSave[indexPath.row][1]
            cell.configureGenre(title: title, emoji: emoji)
            cell.layer.cornerRadius = 15
            return cell
        }
    }
    
    let genresToSave =
    [
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
