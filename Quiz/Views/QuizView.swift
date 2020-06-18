//
//  QuizInfoView.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizView: UIView {
    let appLabel = UILabel()
    let backButton = UIButton(type: .system)
    let leaderboardButton = UIButton(type: .system)
    var quizSubview = UIView()
    var quizTitle = UILabel()
    var quizDescription = UILabel()
    var quizImage = UIImageView()
    var startButton = UIButton(type: .system)
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        quizSubview.backgroundColor = .lightText
        quizSubview.layer.cornerRadius = 20
        quizSubview.translatesAutoresizingMaskIntoConstraints = false
        
        Setup.setLabel(appLabel, size: 32.0, text: "Pop Quiz")
        Setup.setButton(backButton, title: "")
        Setup.setButton(leaderboardButton, title: "Leaderboard")
        leaderboardButton.tintColor = .white
        leaderboardButton.backgroundColor = .systemIndigo
        backButton.backgroundColor = .systemIndigo
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        Utils.underlineText(button: leaderboardButton, text: "Leaderboard")
        
        Setup.setLabel(quizTitle, size: 22.0, isBold: true)
        Setup.setLabel(quizDescription)
        Setup.setButton(startButton, title: "Start quiz")
        
        quizDescription.numberOfLines = 0
        quizImage.layer.masksToBounds = true
        quizImage.layer.cornerRadius = quizImage.frame.width/4.0
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backButton)
        addSubview(appLabel)
        addSubview(leaderboardButton)
        quizSubview.addSubview(quizTitle)
        quizSubview.addSubview(quizDescription)
        quizSubview.addSubview(startButton)
        quizSubview.addSubview(quizImage)
        addSubview(quizSubview)
    }
    
    func setupConstraints() {
        backButton.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.topAnchor.constraint(equalTo:self.topAnchor, constant:40).isActive = true
        backButton.rightAnchor.constraint(equalTo: appLabel.leftAnchor, constant: 60).isActive = true
        
        appLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        appLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        appLabel.topAnchor.constraint(equalTo:self.topAnchor, constant:40).isActive = true
        
        leaderboardButton.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 60).isActive = true
        leaderboardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leaderboardButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        quizSubview.topAnchor.constraint(equalTo:leaderboardButton.bottomAnchor, constant: 10).isActive = true
        quizSubview.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        quizSubview.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        quizSubview.heightAnchor.constraint(equalToConstant: 470).isActive = true
        
        quizTitle.topAnchor.constraint(equalTo:quizSubview.topAnchor, constant: 10).isActive = true
        quizTitle.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        quizTitle.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        quizTitle.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        quizDescription.topAnchor.constraint(equalTo:quizTitle.bottomAnchor).isActive = true
        quizDescription.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        quizDescription.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        quizDescription.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        quizImage.topAnchor.constraint(equalTo:quizDescription.bottomAnchor, constant: 10).isActive = true
        quizImage.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        quizImage.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        quizImage.heightAnchor.constraint(equalToConstant:200).isActive = true
        
        startButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        startButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        startButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        startButton.topAnchor.constraint(equalTo:quizImage.bottomAnchor, constant:30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
