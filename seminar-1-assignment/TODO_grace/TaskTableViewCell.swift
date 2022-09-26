//
//  TaskTableViewCell.swift
//  TODO_grace
//
//  Created by grace kim  on 2022/09/14.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return "TaskTableViewCell"
    }
    
    var task: task?

    var titleText = UILabel()
    var detailText = UILabel()
    var checkButton = UIButton()
    var editButton = UIButton()
    //var CustomBackgroundColor = UIColor()
    var isChecked : Bool?
    var indexNum : Int?
    var seperatorImageView = UIImageView()
    var checkImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .default, reuseIdentifier: "TaskTableViewCell")
        
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 90).isActive = true
        
        self.contentView.addSubview(titleText)
        self.contentView.addSubview(detailText)
        self.contentView.addSubview(checkButton)
        self.contentView.addSubview(editButton)
        self.contentView.addSubview(seperatorImageView)
        self.contentView.addSubview(editButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 40
        self.clipsToBounds = true
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    
    func configureView(setTask: task){
        self.task = setTask
        if (task!.sectionIndex % 4 == 0){
            self.contentView.backgroundColor = template.firstBackground
        }else if (task!.sectionIndex % 4 == 1){
            self.contentView.backgroundColor = template.secondBackground
        }else if (task!.sectionIndex % 4 == 2){
            self.contentView.backgroundColor = template.thirdBackground
        }else if (task!.sectionIndex % 4 == 3){
            self.contentView.backgroundColor = template.fourthBackground
        }
        
        self.titleText.textColor = .black
        titleText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            titleText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)])
        
        self.detailText.textColor = .systemGray
        detailText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            detailText.topAnchor.constraint(equalTo: self.titleText.bottomAnchor, constant: 15),
            detailText.trailingAnchor.constraint(equalTo: self.checkButton.leadingAnchor, constant: -20),
        ])
        //question: how to make cell size change according to detailText size?
        
        self.titleText.text = setTask.title
        self.titleText.font = UIFont.init(name: "JalnanOTF", size: 16)
        self.detailText.text = setTask.details
        self.isChecked = setTask.isChecked
        
        configureCheckButton(isChecked: setTask.isChecked)
        seperatorImageView.image = UIImage(named: "Line")
        seperatorImageView.translatesAutoresizingMaskIntoConstraints = false
        seperatorImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        seperatorImageView.widthAnchor.constraint(equalToConstant: 337).isActive = true
        seperatorImageView.topAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        configureEditButton()
    }
    
    
    func configureCheckButton(isChecked: Bool){
        

        /*self.checkButton.setImage(buttonImage, for: .normal)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true*/
        
        if (isChecked){
            let buttonImage = UIImage(named: "checked")
            self.checkButton.setImage(buttonImage, for: .normal)
            checkButton.translatesAutoresizingMaskIntoConstraints = false
            checkButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
            checkButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            checkButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
            checkButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
            /*
            self.checkButton.addSubview(self.checkImage)
            let checkImage = UIImage(named: "bi_check")
            self.checkImage.image = checkImage
            self.checkImage.translatesAutoresizingMaskIntoConstraints = false
            self.checkImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
            self.checkImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
            self.checkImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true*/
        }else{
            let buttonImage = UIImage(named: "Ellipse 1")
            self.checkButton.setImage(buttonImage, for: .normal)
            checkButton.translatesAutoresizingMaskIntoConstraints = false
            checkButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
            checkButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            checkButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
            checkButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
        }
        
        self.checkButton.clipsToBounds = true
        checkButton.addTarget(self, action: #selector(didTapCheck), for: .touchUpInside)
    }
    
    
    @objc func didTapCheck(){
        guard let isChecked = self.task?.isChecked else { return }
        if (isChecked){
            self.task?.isChecked = false
        }else{
            self.task?.isChecked = true
        }
        self.configureCheckButton(isChecked: self.task?.isChecked ?? false)
        NotificationCenter.default.post(name: NSNotification.Name("isChecked"), object:
                                            nil, userInfo: ["taskToEdit":self.task])
    }
    
    func configureEditButton(){
        editButton.setImage(UIImage(named: "ei_pencil"), for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.leadingAnchor.constraint(equalTo: self.titleText.trailingAnchor, constant: 5).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.centerYAnchor.constraint(equalTo: self.titleText.centerYAnchor, constant: -2).isActive = true
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
    }
    
    @objc func editTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("didTapEdit"),
                                        object: nil,
                                        userInfo: ["task": self.task]
                                        )
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }

}

struct task{
    var sectionIndex : Int
    var title : String
    var details : String?
    var isChecked : Bool
}


