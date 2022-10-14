//
//  MoviesListCollectionViewCell.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit

///cell used for list views --> has movie poster, title, and rating on top of image
class MoviesListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoviesListCollectionViewCell"
    var my_movie : Movie?
    
    let ratingAttachment = NSTextAttachment()
    var posterImage : UIImage?
    var posterView = UIImageView()
    var posterURL : URL?
    var rating : Double?
    var ratingLabel = UILabel()
    var titleLabel = UILabel()
    
    override var reuseIdentifier: String{
        return "MoviesListCollectionViewCell"
    }
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(posterView)
        //self.contentView.addSubview(ratingLabel)
        self.contentView.addSubview(titleLabel)
        configureImage()
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureMovie(_ movie: Movie){
        self.my_movie = movie
        self.posterURL = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")!
        self.rating = movie.voteAverage
        self.titleLabel.text = movie.title
    }
    
    func configureImage(){
        self.load(url: (self.posterURL ?? URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/AeyiuQUUs78bPkz18FY3AzNFF8b.jpg"))!)
        self.posterView.image = self.posterImage
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.posterView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        self.posterView.addSubview(ratingLabel)
        ratingLabel.text = "⭐️ \(String(describing: self.my_movie?.voteAverage))"
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.backgroundColor = UIColor(red: 88/255.0, green: 88/255.0, blue: 88/255.0, alpha: 0.5)
        ratingLabel.layer.cornerRadius = 10
        
        ratingLabel.topAnchor.constraint(equalTo: self.posterView.topAnchor, constant: 5).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: self.posterView.leadingAnchor, constant: 5).isActive = true
    }
    
    func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.posterImage = image
                        }
                    }
                }
            }
        }
    
    func configureTitle(){
        self.titleLabel.text = self.my_movie?.title
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 7).isActive = true
        self.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.titleLabel.textColor = .white
    }
    
    
}
