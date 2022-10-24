//
//  MovieGenreCollectionViewCell.swift
//  movies
//
//  Created by grace kim  on 2022/10/23.
//

import UIKit

class MovieGenreCollectionViewCell: UICollectionViewCell {
    
    var emojiLabel = UILabel()
    var nameLabel = UILabel()
   
   
    
    
    override var reuseIdentifier: String {
        return "MovieGenreCollectionViewCell"
    }
    
    override var isSelected: Bool {
            didSet{
                if isSelected {
                    //add halo affect
                    nameLabel.textColor = .white
                    NotificationCenter.default.post(name: NSNotification.Name("didTapChangeGenreFilter"), object: nil, userInfo: ["filtername": self.nameLabel.text])
                }
                else {
                    
                    self.nameLabel.textColor = Styles.darkGrey
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(emojiLabel)
        self.contentView.addSubview(nameLabel)
        configureDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureGenre(title: String, emoji: String){
        self.nameLabel.text = title
        self.emojiLabel.text = emoji
    }
    
    func configureDesign(){
        self.emojiLabel.layer.cornerRadius = 15
        self.emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emojiLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emojiLabel.backgroundColor = UIColor(red: 39/255.0, green: 40/255.0, blue: 51/255.0, alpha: 1.0)
        self.emojiLabel.layer.cornerRadius = 15
        self.emojiLabel.textAlignment = .center
        self.emojiLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.emojiLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-10).isActive = true
        self.emojiLabel.layer.masksToBounds = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.emojiLabel.bottomAnchor, constant: 8).isActive = true
        self.nameLabel.textColor = Styles.darkGrey
        self.nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    @objc func didTapChangeGenre(_ button : UIButton){
        
    }
    
    
}
