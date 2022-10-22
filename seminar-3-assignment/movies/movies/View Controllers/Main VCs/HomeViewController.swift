//
//  HomeViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//


import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    

    private let defaults = UserDefaults.standard
    private var endPoint = MovieListEndPoint.popular
    private var endPointState = MovieListState.shared
    
    //private var dataSource = Observable<[String]>.of((1...30).map(String.init))
    //private var dataSource = Observable<[Movie]>.of(endPointState)
    
    private let item: CustomTabItem
    let titleLabel = UILabel()
    let headerLabel = UILabel()
    let profilePic = UIButton()
    let searchBar = UISearchBar()
    //let categoryStack = CategoryStackView()
    //change it into a collection view?
    let categoryStack = UIView()
    let categoryLabel = UILabel()
    
    var codeSegmented = CustomSegmentedControl(buttonTitle: ["Popular","Top Rated"])
    
    let recentButton = UIButton()
    let popularButton = UIButton()
    //let movieListView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var movieListView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
   // let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    init(item: CustomTabItem) {
            self.item = item
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        endPointState.loadMovies(with: endPoint)
        print(endPointState.movies?[0].title)
        GenreListState.shared.loadGenres()
        print(GenreListState.shared.genres?[0].name)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = Styles.backgroundBlue
        self.view.addSubview(titleLabel)
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(searchBar)
        self.view.addSubview(categoryLabel)
        self.view.addSubview(categoryStack)
        self.view.addSubview(codeSegmented)
        movieListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.movieListView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
        self.view.addSubview(movieListView)
        
        configureHeader()
        configureSearchBar()
        configureCategoryStack()
        configureSegmentedControl()
        configureMovieList()
    }
    
    @objc func didTapGoBack(){
        
    }
    
    @objc func didTapLike(){
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as! MoviesListCollectionViewCell
        
        guard let movie = self.endPointState.movies?[indexPath.row] else { return UICollectionViewCell() }
        cell.configureMovie(movie)
        return cell
    }
    
    //pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y

        if offsetY > (self.movieListView.contentSize.height - 100 - scrollView.frame.size.height){
            self.endPointState.appendMovies(with: self.endPoint)
            DispatchQueue.main.async {
                self.movieListView.reloadData()
            }
            }
    }
    
    
    func configureMovieList(){
        layout.scrollDirection = .vertical
        movieListView.setCollectionViewLayout(layout, animated: true)
        movieListView.dataSource = self
        movieListView.showsVerticalScrollIndicator = false
        movieListView.delegate = self
        movieListView.backgroundColor = .clear
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.topAnchor.constraint(equalTo: self.codeSegmented.bottomAnchor, constant: 10).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-24)/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.endPointState.movies?.count ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = MovieDetailViewController(movie: (endPointState.movies?[indexPath.item])!)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
}

extension HomeViewController {
    
    func configureHeader(){
        self.titleLabel.text = "Welcome User! 👋"
        self.titleLabel.textColor = Styles.darkGrey
        self.titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        
        
        self.headerLabel.text = "Let's relax and watch a movie!"
        self.headerLabel.textColor = .white
        self.headerLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        self.headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        
        self.profilePic.setImage(UIImage(named: "profile"), for: .normal)
        self.profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.profilePic.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.profilePic.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
    }
    
    func configureSearchBar(){
        self.searchBar.backgroundColor = UIColor(red: 39/255.0, green: 40/255.0, blue: 51/255.0, alpha: 1.0)
        self.searchBar.barTintColor = UIColor(red: 39/255.0, green: 40/255.0, blue: 51/255.0, alpha: 1.0)
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.searchTextField.backgroundColor = UIColor(red: 39/255.0, green: 40/255.0, blue: 51/255.0, alpha: 1.0)
        self.searchBar.placeholder = "Search movies, actors..."
        self.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 25
        self.searchBar.clipsToBounds = true
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 25).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -24).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.categoryLabel.text = "Category"
        self.categoryLabel.textColor = .white
        self.categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.categoryLabel.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 25).isActive = true
    }
    
    func configureCategoryStack(){
         self.categoryStack.translatesAutoresizingMaskIntoConstraints = false
         self.categoryStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
         self.categoryStack.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 8).isActive = true
        self.categoryStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.categoryStack.widthAnchor.constraint(equalToConstant: self.view.frame.width-48).isActive = true
        self.categoryStack.backgroundColor = .clear
     }
    
    //view switch with segmeneted control
    func configureSegmentedControl(){
        //need to add target to segmented control
        codeSegmented.backgroundColor = .clear
        self.codeSegmented.translatesAutoresizingMaskIntoConstraints = false
        self.codeSegmented.topAnchor.constraint(equalTo: self.categoryStack.bottomAnchor, constant: 25).isActive = true
        self.codeSegmented.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.codeSegmented.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.codeSegmented.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        NotificationCenter.default.addObserver(forName: Notification.Name("changedFilter"), object: nil, queue: nil, using: didTapChangeFilter)
        
    }
    
    @objc func didTapChangeFilter(_ notification: Notification) -> Void{
        if (codeSegmented.selectedIndex == 0){
            self.endPoint = MovieListEndPoint.popular
        }else if (codeSegmented.selectedIndex == 1){
            self.endPoint = MovieListEndPoint.topRated
        }
        
        endPointState.initParams()
        self.endPointState.loadMovies(with: self.endPoint)
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            //TODO: fix + and make go back to top when changed? 
            self.movieListView.reloadData()
        }
    }
}


    
    
   

