//
//  SettingsView.swift
//  Quiz
//
//  Created by Lucija Balja on 19/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    var usernameTitle = UILabel()
    var usernameLabel = UILabel()
    var logoutButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        backgroundColor = .systemIndigo
        
        usernameTitle.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        usernameTitle.translatesAutoresizingMaskIntoConstraints = false
        usernameTitle.textColor = .white
        usernameTitle.textAlignment = .left
        usernameTitle.text = "USERNAME"
        
        usernameLabel.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.textColor = .white
        usernameLabel.text = "Lucija"
        usernameLabel.textAlignment = .left
        
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "AvenirNext", size: 20.0)
        logoutButton.backgroundColor = .white
        logoutButton.alpha = 0.9
        logoutButton.tintColor = .systemRed
        logoutButton.layer.cornerRadius = 20
        logoutButton.clipsToBounds = true
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(usernameTitle)
        addSubview(usernameLabel)
        addSubview(logoutButton)
    }
    
    func setupConstraints() {
        usernameTitle.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        usernameTitle.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        usernameTitle.heightAnchor.constraint(equalToConstant:30).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo:usernameTitle.bottomAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        logoutButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        logoutButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        logoutButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
