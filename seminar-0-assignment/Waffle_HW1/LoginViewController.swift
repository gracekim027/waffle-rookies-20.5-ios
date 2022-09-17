//
//  ViewController.swift
//  Waffle_HW1
//
//  Created by grace kim  on 2022/09/07.
//

import UIKit

struct Constants{
    static let verticalPadding : CGFloat = 30.0
    static let horizontalPadding: CGFloat = 24.0
    static let textFieldborderWidth : CGFloat = 0.3
    static let labelWidth : CGFloat = 100.0
    static let fieldWidth : CGFloat = 200.0
}

struct User{
    var username : String
    var email : String
}


class LoginViewController: UIViewController{
    
    var titleLabel = UILabel()
    
    var usernameLabel = UILabel()
    var usernameField = UITextField()
    var usernameStack = UIStackView()
    
    var emailLabel = UILabel()
    var emailField = UITextField()
    var emailStack = UIStackView()
    
    var passwordLabel = UILabel()
    var passwordField = UITextField()
    var passwordStack = UIStackView()
    
    var loginButton = UIButton()
    
    var mainStack = UIStackView()
    
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(mainStack)
       
        configureMainStack()
        
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        //self.title = "로그인"
    }

    
    func configureTitleLabel(){
        titleLabel.text = "로그인"
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
    
    
    func configureUsernameField(){
        usernameField.setLeftPaddingPoints(5)
        usernameField.returnKeyType = .continue
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        usernameField.layer.masksToBounds = true
        usernameField.layer.cornerRadius = 8.0
        usernameField.layer.borderWidth = 0.3
        usernameField.layer.borderColor = UIColor.systemGray.cgColor
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        //Question: constraint 설정. Stack 안에서 각 아이템 constraint 설정 + 스택도 따로 설정해야함..?
        usernameField.widthAnchor.constraint(equalToConstant: Constants.fieldWidth).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureUsernameStack(){
        usernameStack.addArrangedSubview(usernameLabel)
        usernameStack.addArrangedSubview(usernameField)
        
        configureUsernameLabel()
        configureUsernameField()
        
        usernameStack.axis = .horizontal
        usernameStack.distribution = .fillProportionally
        usernameStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        usernameStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        usernameStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureEmailLabel(){
        emailLabel.text = "이메일"
        emailLabel.textColor = .systemGray
        emailLabel.textAlignment = .left
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureEmailField(){
        //emailField.placeholder = "이메일을 입력하세요."
        emailField.setLeftPaddingPoints(5)
        emailField.returnKeyType = .continue
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 8.0
        emailField.layer.borderWidth = 0.3
        emailField.layer.borderColor = UIColor.systemGray.cgColor
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalToConstant: Constants.fieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureEmailStack(){
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailField)
        
        configureEmailLabel()
        configureEmailField()
        
        emailStack.axis = .horizontal
        emailStack.distribution = .fillProportionally
        emailStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        emailStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        emailStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configurePasswordLabel(){
        passwordLabel.text = "비밀번호"
        passwordLabel.textColor = .systemGray
        passwordLabel.textAlignment = .left
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configurePasswordField(){

        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(5)
        
        //passwordField.placeholder = "비밀번호를 입력하세요."
        passwordField.returnKeyType = .continue
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 8.0
        passwordField.layer.borderWidth = 0.3
        passwordField.layer.borderColor = UIColor.systemGray.cgColor
    
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalToConstant: Constants.fieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configurePasswordStack(){
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordField)
        
        configurePasswordLabel()
        configurePasswordField()
        
        passwordStack.axis = .horizontal
        passwordStack.distribution = .fillProportionally
        passwordStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        passwordStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        passwordStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureLoginButton(){
        loginButton.setTitle("로그인", for: .normal)
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = .systemGray
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //question: how to make the width of login stay put and not change
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    

    func configureMainStack(){
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(usernameStack)
        mainStack.addArrangedSubview(emailStack)
        mainStack.addArrangedSubview(passwordStack)
        mainStack.addArrangedSubview(loginButton)
        
        configureTitleLabel()
        configureUsernameStack()
        configureEmailStack()
        configurePasswordStack()
        configureLoginButton()

        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.spacing = Constants.verticalPadding
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        mainStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 200+Constants.verticalPadding*4).isActive = true
    }
    

    @objc private func didTapLogin(){
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        
        guard let username = usernameField.text else {
            return
        }
        
        guard let email = emailField.text else {
            return
        }
        
        //login functionality
        if (username.count >= 2){
            self.dismiss(animated: true, completion: nil)
            let VC = NextViewController()
            let someUser = User(username: username, email: email)
            defaults.set(username, forKey: "username")
            defaults.set(email, forKey: "useremail")
            VC.setUserData(someUser: someUser)
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else {
            //alert view
            let alert = UIAlertController(title: "로그인 실패", message: "username 은 두 글자 이상이어야 합니다.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
              alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

    

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLogin()
        }
        return true
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: 40))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

