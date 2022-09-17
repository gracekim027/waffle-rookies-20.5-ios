//
//  NextViewController.swift
//  Waffle_HW1
//
//  Created by grace kim  on 2022/09/08.
//

import UIKit

class NextViewController: UIViewController{

    var titleLabel = UILabel()
    
    var emailLabel = UILabel()
    var realEmail = UILabel()
    var emailStack = UIStackView()
    
    var usernameLabel = UILabel()
    var realUsername = UILabel()
    var usernameStack = UIStackView()
    
    var mainStack = UIStackView()
    
    var logoutButton = UIButton()
    
    var userName : String?
    var userEmail : String?
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(mainStack)
        
        configureMainStack()
        //self.logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        self.navigationItem.hidesBackButton = true
    }
    
    func setUserData(someUser : User) {
        self.userName = someUser.username
        self.userEmail = someUser.email
    }
    
    func configureTitleLabel() {
        titleLabel.text = "유저 정보"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func configureUsernameLabel(){
        usernameLabel.text = "유저 이름"
        usernameLabel.textColor = .systemGray
        emailLabel.textAlignment = .left
        usernameLabel.sizeToFit()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureRealUsername(){
        let savedUsername = defaults.string(forKey: "username")
        realUsername.text = savedUsername ?? ""
        realUsername.textColor = .black
        realUsername.textAlignment = .left
        realUsername.sizeToFit()
        realUsername.translatesAutoresizingMaskIntoConstraints = false
        realUsername.widthAnchor.constraint(equalToConstant: Constants.fieldWidth).isActive = true
        realUsername.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureUsernameStack(){
        usernameStack.addArrangedSubview(usernameLabel)
        usernameStack.addArrangedSubview(realUsername)
        
        configureUsernameLabel()
        configureRealUsername()
        
        usernameStack.axis = .horizontal
        usernameStack.distribution = .fillProportionally
        usernameStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        usernameStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        usernameStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureEmailLabel () {
        emailLabel.text = "이메일"
        emailLabel.textColor = .systemGray
        emailLabel.textAlignment = .left
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureRealEmail(){
        let savedEmail = defaults.string(forKey: "useremail")
        realEmail.text = savedEmail ?? ""
        realEmail.textColor = .black
        realEmail.textAlignment = .left
        realEmail.translatesAutoresizingMaskIntoConstraints = false
        realEmail.widthAnchor.constraint(equalToConstant: Constants.fieldWidth).isActive = true
        realEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureEmailStack() {
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(realEmail)
        
        configureEmailLabel()
        configureRealEmail()
        
        emailStack.axis = .horizontal
        emailStack.distribution = .fillProportionally
        emailStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        emailStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        emailStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    func configureLogoutButton(){
        logoutButton.setTitle("로그아웃", for: .normal)
        
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 8.0
        logoutButton.backgroundColor = .systemGray
        logoutButton.setTitleColor(.white, for: .normal)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
    
    func configureMainStack(){
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(usernameStack)
        mainStack.addArrangedSubview(emailStack)
        mainStack.addArrangedSubview(logoutButton)
        
        configureTitleLabel()
        configureUsernameStack()
        configureEmailStack()
        configureLogoutButton()
        
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.spacing = Constants.verticalPadding
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        mainStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 160+Constants.verticalPadding*3).isActive = true
    }

    
    @objc func didTapLogout(){
        self.navigationController?.popViewController(animated: true)
    }
}

