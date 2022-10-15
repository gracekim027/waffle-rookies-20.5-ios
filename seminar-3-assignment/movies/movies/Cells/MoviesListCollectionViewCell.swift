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
    
    var ratingAttachment = NSTextAttachment()
    var posterImage : UIImage?
    var posterView = UIImageView()
    var rating : Double?
    var ratingLabel = UILabel()
    var titleLabel = UILabel()
    //question: difference of using var and let in cell?
    
    override var reuseIdentifier: String{
        return "MoviesListCollectionViewCell"
    }
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(posterView)
        self.contentView.addSubview(ratingLabel)
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
        ratingLabel.text = " ⭐️ \(String(describing: movie.voteAverage)) "
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")!
        self.posterView.load(url: posterURL)
        self.posterView.contentMode = .scaleToFill
        self.posterView.layer.masksToBounds = true
        self.titleLabel.text = movie.title
    }
    
    func configureImage(){
        self.posterView.layer.cornerRadius = 15
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.posterView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        //self.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        self.posterView.addSubview(ratingLabel)
        ratingLabel.layer.cornerRadius = 8
        ratingLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.backgroundColor = UIColor(red: 88/255.0, green: 88/255.0, blue: 88/255.0, alpha: 0.5)
        ratingLabel.layer.masksToBounds = true
        
        ratingLabel.topAnchor.constraint(equalTo: self.posterView.topAnchor, constant: 5).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: self.posterView.leadingAnchor, constant: 5).isActive = true
        ratingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
    }
    
    
    func configureTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //self.titleLabel.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 7).isActive = true
        self.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        //self.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.titleLabel.textColor = .white
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
