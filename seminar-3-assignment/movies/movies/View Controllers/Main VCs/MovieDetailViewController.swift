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
    var genreLabel = UILabel()
    var relaseYear = UILabel()
    var rating = UILabel()
    
    var genreView = UIView()
    var yearView = UIView()
    var ratingView = UIView()
    
    init(movie : Movie){
        self.my_movie = movie
        let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")!
        self.posterView.load(url: posterURL)
        self.titleLabel.text = movie.title
        let genreCode = movie.genreIDs[0]
        let genreName = GenreListState.shared.findGenreTitle(with: genreCode)
        self.genreLabel.text = "Genre \n\(genreName)"
        //from genreListState get string of genreCode
        
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
        self.view.addSubview(genreView)
        
        configurePosterView()
        configureSubLabels()
    }
    
    func configurePosterView(){
        self.posterView.layer.cornerRadius = 22
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.posterView.widthAnchor.constraint(equalToConstant: 209).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        self.posterView.heightAnchor.constraint(equalToConstant: 309).isActive = true
        self.posterView.contentMode = .scaleAspectFill
        
        self.posterView.layer.masksToBounds = true
    }
    
    func configureSubLabels(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 20).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.titleLabel.textAlignment = .left
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.numberOfLines = 1
        self.titleLabel.adjustsFontSizeToFitWidth = true
        

        //genre view
        let icon = UIImageView()
        
        genreView.addSubview(icon)
        let iconImage = UIImage(systemName: "video.fill")
        icon.image = iconImage
        genreView.addSubview(genreLabel)
        genreView.addSubview(icon)
        genreView.layer.borderWidth = 1
        genreView.layer.borderColor = Styles.darkGrey.cgColor
        genreView.layer.cornerRadius = 15
        genreView.translatesAutoresizingMaskIntoConstraints = false
        genreView.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 24).isActive = true
        genreView.heightAnchor.constraint(equalToConstant: 93).isActive = true
        genreView.widthAnchor.constraint(equalToConstant: 98).isActive = true
        genreView.topAnchor.constraint(equalTo: self.posterView.topAnchor).isActive = true
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: self.genreView.topAnchor, constant: 20).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 17).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.genreView.centerXAnchor).isActive = true
        icon.contentMode = .scaleToFill
        icon.layer.masksToBounds = true
        
        genreLabel.textColor = .white
        genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.centerXAnchor.constraint(equalTo: self.genreView.centerXAnchor).isActive = true
        genreLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 15).isActive = true
        
    }
}
