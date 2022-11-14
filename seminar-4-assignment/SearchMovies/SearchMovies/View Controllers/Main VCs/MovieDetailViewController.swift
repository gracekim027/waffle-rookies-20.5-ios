//
//  MovieDetailViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/14.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {

    private var my_movie : Movie

    private var posterView = UIImageView()
    
    private var titleLabel = UILabel()
    private var divider = UILabel()
    
    private var icon = UIImageView()
    private var genreLabel = UILabel()
    private var realGenre = UILabel()
    private var genreView = UIView()
    
    private var icon2 = UIImageView()
    private var relaseYear = UILabel()
    private var realYear = UILabel()
    private var yearView = UIView()
    
    private var icon3 = UIImageView()
    private var rating = UILabel()
    private var likeButton = UIButton()
    private var ratingView = UIView()
    private var realRating = UILabel()
    
    private var summaryTitle = UILabel()
    private var summaryLabel = UILabel()
   
    init(movie : Movie){
        self.my_movie = movie
        let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")!
        self.posterView.load(url: posterURL)
        self.realRating.text = "\(my_movie.voteAverage) / 10"
        self.rating.text = "Rating"
        self.titleLabel.text = movie.title
        let genreCode = movie.genreIDs[0]
        let genreName = GenreListState.shared.findGenreTitle(with: genreCode)
        self.genreLabel.text = "Genre"
        self.realGenre.text = "\(genreName)"
        let yearText = movie.releaseDate.components(separatedBy: "-")
        self.realYear.text = yearText[0]
        self.summaryLabel.text = movie.overview
        
        if (LikedMovieState.shared.LikedMovies.contains( where: {$0.id == movie.id} )){
            likeButton.isSelected = true
        }else{
            likeButton.isSelected = false
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Details"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.view.backgroundColor = Styles.backgroundBlue
        addSubviews()
        configureSubviews()
        
    }
    
    private func addSubviews(){
        self.view.addSubview(posterView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(divider)
        
        self.view.addSubview(genreView)
        self.view.addSubview(yearView)
        self.view.addSubview(ratingView)
        
        self.view.addSubview(summaryTitle)
        self.view.addSubview(summaryLabel)
    }
    
    private func configureSubviews(){
        configureTabButtons()
        configurePosterView()
        configureSubLabels()
        configureSummary()
    }
    
    
    //--------configure subviews------------
    
    private func configureTabButtons(){
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        
        let like = UIBarButtonItem(customView: likeButton)
        like.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -24)
        self.navigationItem.setRightBarButton(like, animated: true)
        likeButton.tintColor = .white
        
        
        let backButtonBackgroundImage = UIImage(systemName: "chevron.backward")
        self.navigationController?.navigationBar.backIndicatorImage = backButtonBackgroundImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    
    @objc func didTapLike(){
        if (self.my_movie.liked == false){
            //adding to liked movie list
            self.my_movie.liked = true
            self.likeButton.isSelected = true
            NotificationCenter.default.post(name: NSNotification.Name("didTapLike"), object: nil, userInfo: ["movie": self.my_movie])
        }else {
            //removing from liked movie list
            self.my_movie.liked = false
            self.likeButton.isSelected = false
            NotificationCenter.default.post(name: NSNotification.Name("didTapNotLike"), object: nil, userInfo: ["movie": self.my_movie])
        }
    }
    
    func configurePosterView(){
        self.posterView.layer.cornerRadius = 22
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.posterView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110).isActive = true
        self.posterView.heightAnchor.constraint(equalToConstant: 325.26).isActive = true
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
        
        self.divider.backgroundColor = Styles.fontGrey
        self.divider.translatesAutoresizingMaskIntoConstraints = false
        self.divider.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14).isActive = true
        self.divider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        self.divider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        self.divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        genreView.addSubview(icon)
        let iconImage = UIImage(named: "camera")
        icon.image = iconImage
        genreView.addSubview(genreLabel)
        genreView.addSubview(realGenre)
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
        
        genreLabel.textColor = Styles.fontGrey
        genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.centerXAnchor.constraint(equalTo: self.genreView.centerXAnchor).isActive = true
        genreLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 13).isActive = true
        genreLabel.numberOfLines = 2
        
        realGenre.textColor = .white
        realGenre.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        realGenre.translatesAutoresizingMaskIntoConstraints = false
        realGenre.centerXAnchor.constraint(equalTo: self.genreView.centerXAnchor).isActive = true
        realGenre.topAnchor.constraint(equalTo: self.genreLabel.bottomAnchor, constant: 3).isActive = true
        
        
        yearView.addSubview(icon2)
        let iconImage2 = UIImage(named: "calendar")
        icon2.image = iconImage2
        yearView.addSubview(relaseYear)
        yearView.addSubview(realYear)
        yearView.layer.borderWidth = 1
        yearView.layer.borderColor = Styles.darkGrey.cgColor
        yearView.layer.cornerRadius = 15
        yearView.translatesAutoresizingMaskIntoConstraints = false
        yearView.topAnchor.constraint(equalTo: genreView.bottomAnchor, constant: 22).isActive = true
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
        
        relaseYear.textColor = Styles.fontGrey
        relaseYear.text = "Release Year"
        relaseYear.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        relaseYear.translatesAutoresizingMaskIntoConstraints = false
        relaseYear.centerXAnchor.constraint(equalTo: self.yearView.centerXAnchor).isActive = true
        relaseYear.topAnchor.constraint(equalTo: icon2.bottomAnchor, constant: 13).isActive = true
        
        realYear.textColor = .white
        realYear.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        realYear.translatesAutoresizingMaskIntoConstraints = false
        realYear.centerXAnchor.constraint(equalTo: self.yearView.centerXAnchor).isActive = true
        realYear.topAnchor.constraint(equalTo: relaseYear.bottomAnchor, constant: 3).isActive = true
        
        
        ratingView.addSubview(icon3)
        let iconImage3 = UIImage(named: "rating_star")
        icon3.image = iconImage3
        ratingView.addSubview(rating)
        ratingView.addSubview(realRating)
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = Styles.darkGrey.cgColor
        ratingView.layer.cornerRadius = 15
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: yearView.bottomAnchor, constant: 22).isActive = true
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
        
        rating.textColor = Styles.fontGrey
        rating.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.centerXAnchor.constraint(equalTo: self.ratingView.centerXAnchor).isActive = true
        rating.topAnchor.constraint(equalTo: icon3.bottomAnchor, constant: 13).isActive = true
        
        realRating.textColor = .white
        realRating.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        realRating.translatesAutoresizingMaskIntoConstraints = false
        realRating.centerXAnchor.constraint(equalTo: self.ratingView.centerXAnchor).isActive = true
        realRating.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 3).isActive = true
        
    }
    
    func configureSummary(){
        self.summaryTitle.text = "Storyline"
        self.summaryTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.summaryTitle.textColor = .white
        self.summaryTitle.translatesAutoresizingMaskIntoConstraints = false
        self.summaryTitle.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 20).isActive = true
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
    }
    
    
}
