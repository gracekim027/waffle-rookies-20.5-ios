//
//  CategoryStackView.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit

/*
class CategoryStackView: UIStackView {
    
    var buttons : [UIButton] = []
    
    //action: 😮‍💨
    //comedy: 😝
    //drama: 😢
    //horror: 😱
    //mystery: 🤫
    //romance: 😘
    //sci-fi: 🤯
    //history: 🤠
    
    init(){
        super.init(frame: .zero)
        configureButtons()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtons(){
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 30
        let actionButton = categoryButton(name: "action", emoji: "😮‍💨")
        let comedyButton = categoryButton(name: "comedy", emoji: "😝")
        let dramaButton = categoryButton(name: "drama", emoji: "😢")
        let horrorButton = categoryButton(name: "horror", emoji: "😱")
        let mysteryButton = categoryButton(name: "mystery", emoji: "🤫")
        let romanceButton = categoryButton(name: "romance", emoji: "😘")
        let sci_fiButton = categoryButton(name: "sci-fi", emoji: "🤯")
        let historyButton = categoryButton(name: "history", emoji: "🤠")
        buttons.append(actionButton)
        buttons.append(comedyButton)
        buttons.append(dramaButton)
        buttons.append(horrorButton)
        buttons.append(mysteryButton)
        buttons.append(romanceButton)
        buttons.append(sci_fiButton)
        buttons.append(historyButton)
    }
}

class categoryButton : UIButton {
    var name : String
    var emoji : String
    
    let emojiLabel = UILabel()
    let nameLabel = UILabel()
    
    init(name: String, emoji: String){
        self.emoji = emoji
        self.name = name
        super.init(frame: .zero)
        configureDesign()
    }
    
    func configureDesign(){
        self.emojiLabel.text = emoji
        self.nameLabel.text = name
        self.emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emojiLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emojiLabel.backgroundColor = UIColor(red: 39/255.0, green: 40/255.0, blue: 51/255.0, alpha: 1.0)
        self.emojiLabel.layer.cornerRadius = 15
        self.emojiLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.frame.height-10).isActive = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.emojiLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}*/
