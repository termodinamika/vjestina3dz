//
//  LoginView.swift
//  Quiz
//
//  Created by Lucija Balja on 28/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var appLabel = UILabel()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton(type: .system)
    var loginDelegate: LoginDelegate?
    var errorLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        setupAutoContstraints()
        setupEvents()
    }
    
    func setupEvents() {
        loginButton.addTarget(self, action: #selector(onLoginPressed), for: .touchUpInside)
    }
    
    @objc func onLoginPressed() {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            self.loginDelegate?.onLoginPressed(username: username, password: password)
        } 
    }
    
    private func setupUI() {
        backgroundColor = .systemIndigo
        
        appLabel.font = UIFont(name: "AvenirNext-Bold", size: 32.0)
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        appLabel.text = "Pop Quiz"
        appLabel.textColor = .white
        appLabel.textAlignment = .center
        
        usernameTextField.placeholder = "Enter username"
        usernameTextField.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        usernameTextField.textColor = UIColor.darkGray
        usernameTextField.alpha = 0.8
        usernameTextField.minimumFontSize = 17.0
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.text = "36495264"
        
        passwordTextField.placeholder = "Enter password"
        passwordTextField.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        passwordTextField.textColor = UIColor.darkGray
        passwordTextField.alpha = 0.8
        passwordTextField.minimumFontSize = 17.0
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text =  "36495264"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .white
        loginButton.alpha = 0.9
        loginButton.tintColor = .systemIndigo
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.backgroundColor = .white
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 0.8
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        addSubview(appLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(errorLabel)
    }
    
    private func setupAutoContstraints() {
        
        appLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        appLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        appLabel.topAnchor.constraint(equalTo:self.topAnchor, constant:60).isActive = true
        
        usernameTextField.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        usernameTextField.topAnchor.constraint(equalTo:appLabel.bottomAnchor, constant:60).isActive = true
             
        passwordTextField.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant:50).isActive = true

        loginButton.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        loginButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo:loginButton.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
