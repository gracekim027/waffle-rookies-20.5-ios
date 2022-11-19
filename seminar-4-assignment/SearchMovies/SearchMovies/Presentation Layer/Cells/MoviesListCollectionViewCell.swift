//
//  MoviesListCollectionViewCell.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SkeletonView

class MoviesListCollectionViewCell: UICollectionViewCell {
    
    var my_movie : Movie?
    var posterView = UIImageView()
    var ratingLabel = UILabel()
    var titleLabel = UILabel()
    
    override var reuseIdentifier: String {
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
        self.posterView.layer.masksToBounds = true
        self.titleLabel.text = movie.title
    }
    
    func configureImage(){
        
        self.posterView.layer.cornerRadius = 25
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.posterView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.posterView.widthAnchor.constraint(equalToConstant: 171).isActive = true
        self.posterView.heightAnchor.constraint(equalToConstant: 252.54).isActive = true
        
        
        self.posterView.contentMode = .scaleToFill
        self.posterView.layer.masksToBounds = true
        self.posterView.showGradientSkeleton()
        
        self.posterView.addSubview(ratingLabel)
        ratingLabel.layer.cornerRadius = 8
        ratingLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.backgroundColor = UIColor(red: 88/255.0, green: 88/255.0, blue: 88/255.0, alpha: 0.5)
        ratingLabel.layer.masksToBounds = true
        
        ratingLabel.topAnchor.constraint(equalTo: self.posterView.topAnchor, constant: 7).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: self.posterView.leadingAnchor, constant: 7).isActive = true
        ratingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
    }
    
    func configureTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 5).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 1
        self.titleLabel.adjustsFontSizeToFitWidth = true
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
