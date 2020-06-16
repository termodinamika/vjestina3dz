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
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            setErrorLabel(text: "Enter valid username and password!")
            return
        }
        errorLabel.isHidden = true
        loginDelegate?.onLoginPressed(username: username, password: password)
    }
    
    func setErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    
    private func setupUI() {
        backgroundColor = .systemIndigo
        
        Setup.setLabel(appLabel, size: 16.0, text: "Pop Quiz")
        Setup.setTextField(usernameTextField, size: 17.0, isBold: false, placeholder: "Enter username" )
        usernameTextField.text = "36495264"
        
        Setup.setTextField(passwordTextField, size: 17.0, isBold: false, placeholder: "Enter password")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text =  "36495264"
        
        Setup.setButton(loginButton, title: "Login")
        Setup.setLabel(errorLabel)
        errorLabel.backgroundColor = .white
        errorLabel.textColor = .systemRed
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
        
        usernameTextField.leftAnchor.constraint(equalTo:self.leftAnchor, constant:-400).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        usernameTextField.topAnchor.constraint(equalTo:appLabel.bottomAnchor, constant:60).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo:self.leftAnchor, constant:-400).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        
        loginButton.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant: -400).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo:loginButton.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
