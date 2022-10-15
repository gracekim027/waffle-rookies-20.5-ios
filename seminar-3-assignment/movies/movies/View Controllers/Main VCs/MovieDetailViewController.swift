//
//  MovieDetailViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/14.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var my_movie : Movie
    
    var posterView = UIImageView()
    var titleLabel = UILabel()
    
    init(movie : Movie){
        self.my_movie = movie
        let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")!
        self.posterView.load(url: posterURL)
        self.titleLabel.text = movie.title
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        let back = UIBarButtonItem(customView: backButton)
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        let like = UIBarButtonItem(customView: likeButton)
        self.navigationItem.leftBarButtonItem = back
        self.navigationItem.rightBarButtonItem = like
        
        self.view.backgroundColor = Styles.backgroundBlue
        self.view.addSubview(posterView)
        self.view.addSubview(titleLabel)
        
        configurePosterView()
        configureSubLabels()
    }
    
    func configurePosterView(){
        self.posterView.layer.cornerRadius = 22
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.posterView.widthAnchor.constraint(equalToConstant: 252).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        self.posterView.heightAnchor.constraint(equalToConstant: 373).isActive = true
        self.posterView.contentMode = .scaleAspectFill
        self.posterView.backgroundColor = .white
        self.posterView.layer.masksToBounds = true
    }
    
    func configureSubLabels(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 30).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.titleLabel.numberOfLines = 1
        self.titleLabel.adjustsFontSizeToFitWidth = true
    }
}
