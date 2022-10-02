//
//  EditTaskViewController.swift
//  TODO_grace
//
//  Created by grace kim  on 2022/09/20.
// in notification use userinfo instead of object

import UIKit

class EditTaskViewController: UIViewController {

    
    var alertMessage = UILabel()
    var alerted : Bool = false
    
    var centeredView = UIView()
    var titleLabel = UILabel()
    var titleField = UITextField()
    
    var detailLabel = UILabel()
    var detailField = UITextField()
    var lineImage = UIImageView()
    var lineImage2 = UIImageView()
    
    var saveButton = UIButton()
    var cancelButton = UIButton()
    
    var task : task
    
    init(self_task : task) {
        self.task =  self_task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(centeredView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleField)
        self.view.addSubview(lineImage)
        self.view.addSubview(detailLabel)
        self.view.addSubview(detailField)
        self.view.addSubview(lineImage2)
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        
        setBackgroundColor()
        configureSubViews()
    }
    
    func setBackgroundColor(){
        centeredView.translatesAutoresizingMaskIntoConstraints = false
        centeredView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48).isActive = true
        centeredView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        centeredView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centeredView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
    
        if (self.task.sectionIndex % 4 == 0){
            centeredView.backgroundColor = template.firstBackground
        }else if (self.task.sectionIndex % 4 == 1){
            centeredView.backgroundColor = template.secondBackground
        }else if (self.task.sectionIndex % 4 == 2){
            centeredView.backgroundColor = template.thirdBackground
        }else if (self.task.sectionIndex % 4 == 3){
            centeredView.backgroundColor = template.fourthBackground
        }
        centeredView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        centeredView.layer.cornerRadius = 30
        centeredView.layer.borderWidth = 3
    }
    
    func configureSubViews(){

        titleLabel.text = "task name"
        titleLabel.font = UIFont(name: "JalnanOTF", size: 16.0)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.centeredView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.centeredView.leadingAnchor, constant: 30).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        //titleField.borderStyle = .roundedRect
        //titleField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
       // titleField.layer.borderWidth =  2
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.borderStyle = .none
        titleField.leadingAnchor.constraint(equalTo: self.centeredView.leadingAnchor, constant: 24).isActive = true
        titleField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleField.widthAnchor.constraint(equalTo: self.centeredView.widthAnchor, constant: -48).isActive = true
        titleField.backgroundColor = .clear
        //titleField.font = UIFont(name: "HelveticaNeue", size: 16.0)
        titleField.text = task.title
        titleField.textColor = .black
        //titleField.layer.cornerRadius = 20
        titleField.clipsToBounds = true
        
        let lineDivider = UIImage(named: "Line 2")
        lineImage.image = lineDivider
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lineImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        lineImage.topAnchor.constraint(equalTo: self.titleField.bottomAnchor).isActive = true
        
        detailLabel.text = "add details"
        detailLabel.font = UIFont(name: "JalnanOTF", size: 16.0)
        detailLabel.textColor = .black
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: self.titleField.bottomAnchor, constant: 20).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: self.centeredView.leadingAnchor, constant: 30).isActive = true
        detailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        
        detailField.borderStyle = .none
        //detailField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        //detailField.layer.borderWidth =  2
        detailField.translatesAutoresizingMaskIntoConstraints = false
        detailField.leadingAnchor.constraint(equalTo: self.centeredView.leadingAnchor, constant: 24).isActive = true
        detailField.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 5).isActive = true
        detailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        detailField.widthAnchor.constraint(equalTo: self.centeredView.widthAnchor, constant: -48).isActive = true
        detailField.backgroundColor = .clear
        //detailField.font = UIFont(name: "HelveticaNeue", size: 16.0)
        detailField.textColor = .black
        detailField.text = self.task.details
        //detailField.layer.cornerRadius = 20
        detailField.clipsToBounds = true
        
        let lineDivider2 = UIImage(named: "Line 2")
        lineImage2.image = lineDivider2
        lineImage2.translatesAutoresizingMaskIntoConstraints = false
        lineImage2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lineImage2.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        lineImage2.topAnchor.constraint(equalTo: self.detailField.bottomAnchor).isActive = true
        
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.widthAnchor.constraint(equalTo: self.centeredView.widthAnchor, constant: -48).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centeredView.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive  = true
        saveButton.topAnchor.constraint(equalTo: self.detailField.bottomAnchor, constant: 50).isActive = true
        let buttonLabel = UILabel()
        saveButton.addSubview(buttonLabel)
        buttonLabel.text = "save"
        buttonLabel.font = UIFont(name: "JalnanOTF", size: 16)
        buttonLabel.textColor = .black
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.centerXAnchor.constraint(equalTo: self.saveButton.centerXAnchor).isActive = true
        buttonLabel.centerYAnchor.constraint(equalTo: self.saveButton.centerYAnchor).isActive = true
        saveButton.clipsToBounds = true
        saveButton.backgroundColor = .clear
        saveButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        saveButton.layer.borderWidth = 3
        saveButton.layer.cornerRadius = 20
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalTo: self.centeredView.widthAnchor, constant: -48).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centeredView.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive  = true
        cancelButton.topAnchor.constraint(equalTo: self.saveButton.bottomAnchor, constant: 20).isActive = true
        let buttonLabel2 = UILabel()
        cancelButton.addSubview(buttonLabel2)
        buttonLabel2.text = "cancel"
        buttonLabel2.font = UIFont(name: "JalnanOTF", size: 16)
        buttonLabel2.textColor = .black
        buttonLabel2.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel2.centerXAnchor.constraint(equalTo: self.cancelButton.centerXAnchor).isActive = true
        buttonLabel2.centerYAnchor.constraint(equalTo: self.cancelButton.centerYAnchor).isActive = true
        cancelButton.clipsToBounds = true
        cancelButton.backgroundColor = .clear
        cancelButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.cornerRadius = 20
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
    }
    
    
    @objc func didTapSave(){
        guard let title = titleField.text else {
            return
        }
        let details = detailField.text ?? ""
        
        
        //If title is not under 20 characters --> make text field shadow and give animation to shake the text field
        if (title.isEmpty || title.count > 20){
            self.view.addSubview(alertMessage)
            alertMessage.text = "title should be under 20 characters!"
            alertMessage.adjustsFontSizeToFitWidth = true
            alertMessage.textColor = .systemRed
            alertMessage.translatesAutoresizingMaskIntoConstraints = false
            alertMessage.widthAnchor.constraint(equalToConstant: 300).isActive = true
            alertMessage.heightAnchor.constraint(equalToConstant: 20).isActive = true
            alertMessage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
            alertMessage.leadingAnchor.constraint(equalTo: self.titleField.leadingAnchor).isActive = true
            
            titleField.layer.shadowColor = UIColor(red: 0.996, green: 0, blue: 0, alpha: 1).cgColor
            titleField.layer.shadowOpacity = 1
            titleField.layer.shadowRadius = 6
            titleField.layer.shadowOffset = CGSize(width: 0, height: 0)
            titleField.layer.borderColor = UIColor(red: 0.996, green: 0, blue: 0, alpha: 1).cgColor
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: titleField.center.x - 10, y: titleField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: titleField.center.x + 10, y: titleField.center.y))
            titleField.layer.add(animation, forKey: "position")
            alerted = true
            
        }else{
            if (alerted){
                titleField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                alertMessage.text = ""
            }
            //ViewModel.addTask(title: title, details: details)
            NotificationCenter.default.post(name: NSNotification.Name("didEditTask"), object: nil, userInfo:
                [
                "task_sectionNum": self.task.sectionIndex,
                "new_title":title,
                "new_details":details,
            ])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func didTapCancel(){
        self.dismiss(animated: true)
    }
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
}
