//
//  LeaderboardView.swift
//  Quiz
//
//  Created by Lucija Balja on 10/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardView: UIView {
    let leaderboardLabel = UILabel()
    let dismissButton = UIButton()
    let tableview = UITableView()
    let errorLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        tableview.register(LeaderboardCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func setErrorLabel() {
        errorLabel.isHidden = false
        errorLabel.text = "Could not fetch leaderboard scores"
    }
    
    func setupUI() {
        backgroundColor = .systemIndigo
        Setup.setLabel(leaderboardLabel, size: 24.0, text: "Leaderboard")
        Setup.setButton(dismissButton, size: 30.0, isBold: true, title: "x")
        Setup.setLabel(errorLabel)
        errorLabel.tintColor = .red
        errorLabel.backgroundColor = .white
        errorLabel.isHidden = true
        
        dismissButton.backgroundColor = .systemIndigo
        dismissButton.tintColor = .white
        
        tableview.backgroundColor = .systemIndigo
        tableview.separatorColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leaderboardLabel)
        addSubview(dismissButton)
        addSubview(errorLabel)
        addSubview(tableview)
    }
    
    func setupConstraints() {
        leaderboardLabel.topAnchor.constraint(equalTo:self.topAnchor, constant: 40).isActive = true
        leaderboardLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        leaderboardLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        dismissButton.leftAnchor.constraint(equalTo:leaderboardLabel.rightAnchor).isActive = true
        dismissButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant: -10).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.topAnchor.constraint(equalTo:self.topAnchor, constant:40).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo:dismissButton.bottomAnchor, constant: 40).isActive = true
        errorLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        
        tableview.topAnchor.constraint(equalTo: self.leaderboardLabel.bottomAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

