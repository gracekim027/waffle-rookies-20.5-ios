//
//  HomeViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//


import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class HomeViewController: UIViewController{
    
    private let bag = DisposeBag()
    
    private let defaults = UserDefaults.standard
    private var endPoint = MovieListEndPoint.popular
    
    
    private let item: CustomTabItem
    let titleLabel = UILabel()
    let headerLabel = UILabel()
    let profilePic = UIButton()
    let searchBar = UISearchBar()

    var codeSegmented = CustomSegmentedControl()
    
    let recentButton = UIButton()
    let popularButton = UIButton()
    
    var popularCollectionView = PopularMoviesViewController()
    var TopRatedCollectionView = TopRatedMoviesViewController()
   
    init(item: CustomTabItem) {
            self.item = item
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {

        //NotificationCenter.default.addObserver(forName: Notification.Name("changedFilter"), object: nil, queue: nil, using: didTapChangeFilter)
        NotificationCenter.default.addObserver(forName: Notification.Name("buttonsSet"), object: nil, queue: nil, using: buttonsSet)
        super.viewDidLoad()
        
        GenreListState.shared.loadGenres()
        print(GenreListState.shared.genres?[0].name)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = Styles.backgroundBlue
        self.view.addSubview(titleLabel)
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(searchBar)
        self.view.addSubview(codeSegmented)
        
        //우선은 popular 부터 보여짐.
        self.add(TopRatedCollectionView)
        self.TopRatedCollectionView.view.frame = CGRect(x: 24, y: 240, width: self.view.frame.width - 48, height: self.view.frame.height)
        self.add(popularCollectionView)
        self.popularCollectionView.view.frame = CGRect(x: 24, y: 240, width: self.view.frame.width - 48, height: self.view.frame.height)
        TopRatedCollectionView.view.isHidden = true
        configureHeader()
        configureSearchBar()
        configureSegmentedControl()
        for button in self.codeSegmented.buttons {
            button.addTarget(self, action: #selector(didTapChangeFilter), for: .touchUpInside)
        }
        
    }
    
   

}

public extension UIViewController {

    /// Adds child view controller to the parent.
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
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
    }

    //view switch with segmeneted control
    func configureSegmentedControl(){
        codeSegmented.backgroundColor = .clear
        self.codeSegmented.translatesAutoresizingMaskIntoConstraints = false
        self.codeSegmented.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 25).isActive = true
        self.codeSegmented.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        self.codeSegmented.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.codeSegmented.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        
        
        
    }
    
    @objc func didTapChangeFilter(){
        //print("did tap change filter")
        if (codeSegmented.selectedIndex == 0){
            self.endPoint = MovieListEndPoint.popular
            self.TopRatedCollectionView.view.isHidden = true
           self.popularCollectionView.view.isHidden = false
                
            
        }else if (codeSegmented.selectedIndex == 1){
            self.endPoint = MovieListEndPoint.topRated
            self.popularCollectionView.view.isHidden = true
         self.TopRatedCollectionView.view.isHidden = false
        }
    }
    
    @objc func buttonsSet(_ notification : Notification)->(){
        for button in self.codeSegmented.buttons {
            button.addTarget(self, action: #selector(didTapChangeFilter), for: .touchUpInside)
        }
    }
    
}


    
    
   

