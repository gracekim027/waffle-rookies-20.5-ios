//
//  HomeViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

//TODO: make the phone turn automatically into dark mode?

import UIKit

class HomeViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private let item: CustomTabItem
    let titleLabel = UILabel()
    let headerLabel = UILabel()
    let profilePic = UIButton()
    let searchBar = UISearchBar()
    //let categoryStack = CategoryStackView()
    let categoryStack = UIView()
    let categoryLabel = UILabel()
    
    var codeSegmented = CustomSegmentedControl(buttonTitle: ["Popular","Top Rated"])
    
   // var filterButton = UISegmentedControl(items: ["Popular", "What's New?"])
    let recentButton = UIButton()
    let popularButton = UIButton()
    let movieListView = UICollectionView(frame: .zero)
    
    init(item: CustomTabItem) {
            self.item = item
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = Styles.backgroundBlue
        self.view.addSubview(titleLabel)
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(searchBar)
        self.view.addSubview(categoryLabel)
        self.view.addSubview(categoryStack)
        self.view.addSubview(codeSegmented)
        self.view.addSubview(movieListView)
        
        configureHeader()
        configureSearchBar()
        configureCategoryStack()
        configureSegmentedControl()
        configureMovieList()
        //question: how to set size for frame that hasn't been defined yet?
        // Do any additional setup after loading the view.
    }
    
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
    
        //filterButton = UISegmentedControl(items: ["Popular", "What's New?"])
        /*
        self.filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.filterButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.filterButton.topAnchor.constraint(equalTo: self.categoryStack.bottomAnchor, constant: 25).isActive = true
        self.filterButton.addTarget(self, action: #selector(didTapChangeFilter), for: .valueChanged)
        self.filterButton.backgroundColor = .clear
        let unselectedAttributes = [NSAttributedString.Key.foregroundColor: Styles.darkGrey,
                                    NSAttributedString.Key.backgroundColor: UIColor.clear,
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        
        let selectedAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.backgroundColor : UIColor.clear,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        
        self.filterButton.setTitleTextAttributes(unselectedAttributes, for: .normal)
        self.filterButton.setTitleTextAttributes(selectedAttributes, for: .selected)*/
        codeSegmented.backgroundColor = .clear
        self.codeSegmented.translatesAutoresizingMaskIntoConstraints = false
        self.codeSegmented.topAnchor.constraint(equalTo: self.categoryStack.bottomAnchor, constant: 25).isActive = true
        self.codeSegmented.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.codeSegmented.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.codeSegmented.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
    }
    
    @objc func didTapChangeFilter(){
        //TODO: change this to post notification 
        print("changed Items!")
    }
    
    func configureMovieList(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        movieListView.collectionViewLayout = layout
        movieListView.dataSource = self
        movieListView.delegate = self
        movieListView.backgroundColor = .clear
        movieListView.topAnchor.constraint(equalTo: self.codeSegmented.bottomAnchor, constant: 10).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as? MoviesListCollectionViewCell else { return UICollectionViewCell() }
        cell.configureMovie(<#T##movie: Movie##Movie#>)
        return cell
    }
    
    
   
}
