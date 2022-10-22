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
    
    var icon = UIImageView()
    var genreLabel = UILabel()
    var genreView = UIView()
    
    var icon2 = UIImageView()
    var relaseYear = UILabel()
    var yearView = UIView()
    
    var icon3 = UIImageView()
    var rating = UILabel()
    var ratingView = UIView()
    
    var summaryTitle = UILabel()
    var summaryLabel = UILabel()
   
    
    init(movie : Movie){
        self.my_movie = movie
        let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")!
        self.posterView.load(url: posterURL)
        self.rating.text = "Rating \n\(my_movie.voteAverage)"
        self.titleLabel.text = movie.title
        let genreCode = movie.genreIDs[0]
        let genreName = GenreListState.shared.findGenreTitle(with: genreCode)
        self.genreLabel.text = "Genre \n\(genreName)"
        let yearText = movie.releaseDate.components(separatedBy: "-")
        self.relaseYear.text = yearText[0]
        self.summaryLabel.text = movie.overview
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        let back = UIBarButtonItem(customView: backButton)
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        let like = UIBarButtonItem(customView: likeButton)
        //self.navigationItem.leftBarButtonItem = back
        self.navigationItem.setLeftBarButton(back, animated: true)
        self.navigationItem.setRightBarButton(like, animated: true)
        //self..navigationItem.rightBarButtonItem = like
        
        self.view.backgroundColor = Styles.backgroundBlue
        
        self.view.addSubview(posterView)
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(genreView)
        self.view.addSubview(yearView)
        self.view.addSubview(ratingView)
        
        self.view.addSubview(summaryTitle)
        self.view.addSubview(summaryLabel)
        
        configurePosterView()
        configureSubLabels()
        configureSummary()
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
        

        
        genreView.addSubview(icon)
        let iconImage = UIImage(named: "camera")
        icon.image = iconImage
        genreView.addSubview(genreLabel)
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
        genreLabel.numberOfLines = 2
        
        
        yearView.addSubview(icon2)
        let iconImage2 = UIImage(named: "calendar")
        icon2.image = iconImage2
        yearView.addSubview(relaseYear)
        yearView.layer.borderWidth = 1
        yearView.layer.borderColor = Styles.darkGrey.cgColor
        yearView.layer.cornerRadius = 15
        yearView.translatesAutoresizingMaskIntoConstraints = false
        yearView.topAnchor.constraint(equalTo: genreView.bottomAnchor, constant: 9).isActive = true
        yearView.heightAnchor.constraint(equalToConstant: 93).isActive = true
        yearView.widthAnchor.constraint(equalToConstant: 98).isActive = true
        yearView.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 24).isActive = true
        
        icon2.translatesAutoresizingMaskIntoConstraints = false
        icon2.topAnchor.constraint(equalTo: self.yearView.topAnchor, constant: 20).isActive = true
        icon2.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon2.heightAnchor.constraint(equalToConstant: 17).isActive = true
        icon2.centerXAnchor.constraint(equalTo: self.yearView.centerXAnchor).isActive = true
        icon2.contentMode = .scaleToFill
        icon2.layer.masksToBounds = true
        
        relaseYear.textColor = .white
        relaseYear.text = "Release Date \n 2018"
        relaseYear.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        relaseYear.translatesAutoresizingMaskIntoConstraints = false
        relaseYear.centerXAnchor.constraint(equalTo: self.yearView.centerXAnchor).isActive = true
        relaseYear.topAnchor.constraint(equalTo: icon2.bottomAnchor, constant: 15).isActive = true
        
        
        ratingView.addSubview(icon3)
        let iconImage3 = UIImage(named: "rating_star")
        icon3.image = iconImage3
        ratingView.addSubview(rating)
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = Styles.darkGrey.cgColor
        ratingView.layer.cornerRadius = 15
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: yearView.bottomAnchor, constant: 9).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 93).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 98).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 24).isActive = true
        
        icon3.translatesAutoresizingMaskIntoConstraints = false
        icon3.topAnchor.constraint(equalTo: self.ratingView.topAnchor, constant: 20).isActive = true
        icon3.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon3.heightAnchor.constraint(equalToConstant: 17).isActive = true
        icon3.centerXAnchor.constraint(equalTo: self.ratingView.centerXAnchor).isActive = true
        icon3.contentMode = .scaleToFill
        icon3.layer.masksToBounds = true
        
        rating.textColor = .white
        rating.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.centerXAnchor.constraint(equalTo: self.ratingView.centerXAnchor).isActive = true
        rating.topAnchor.constraint(equalTo: icon3.bottomAnchor, constant: 15).isActive = true
        
    }
    
    func configureSummary(){
        self.summaryTitle.text = "Storyline"
        self.summaryTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.summaryTitle.textColor = .white
        self.summaryTitle.translatesAutoresizingMaskIntoConstraints = false
        self.summaryTitle.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.summaryTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.summaryTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        
        self.summaryLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.summaryLabel.textColor = Styles.darkGrey
        self.summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.summaryLabel.topAnchor.constraint(equalTo: self.summaryTitle.bottomAnchor, constant: 10).isActive = true
        self.summaryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.summaryLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.summaryLabel.textAlignment = .left
        self.summaryLabel.numberOfLines = 0
       // self.summaryLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
}
