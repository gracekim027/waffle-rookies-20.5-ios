//
//  HomeViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit


class HomeViewController: UIViewController {
    
    let titleLabel = UILabel()
    let headerLabel = UILabel()
    let profilePic = UIButton()
    let searchBar = UISearchBar()
    //let categoryStack = CategoryStackView()
    let categoryStack = UIView()
    let categoryLabel = UILabel()

    
    var filterButton = UISegmentedControl(items: ["Popular", "What's New?"])
    let recentButton = UIButton()
    let popularButton = UIButton()
   // let movieListView = UICollectionView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = Styles.backgroundBlue
        self.view.addSubview(titleLabel)
        self.view.addSubview(headerLabel)
        self.view.addSubview(profilePic)
        self.view.addSubview(searchBar)
        self.view.addSubview(categoryLabel)
        self.view.addSubview(categoryStack)
        self.view.addSubview(filterButton)
       // self.view.addSubview(movieListView)
        
        configureHeader()
        configureSearchBar()
        configureCategoryStack()
        configureSegmentedControl()
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
       self.categoryStack.backgroundColor = .darkGray
    }
    
    //view switch with segmeneted control
    func configureSegmentedControl(){
    
        //filterButton = UISegmentedControl(items: ["Popular", "What's New?"])
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
        self.filterButton.setTitleTextAttributes(selectedAttributes, for: .selected)
        
    }
    
    @objc func didTapChangeFilter(){
        
    }
    
}