//
//  QuizInfoView.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizView: UIView {
    var quizTitle = UILabel()
    var quizImage = UIImageView()
    var startButton = UIButton(type: .system)
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightText
        layer.cornerRadius = 20
        
        Setup.setLabel(quizTitle)
        Setup.setButton(startButton, title: "Start quiz")
        
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(quizTitle)
        addSubview(startButton)
        addSubview(quizImage)
    }
    
    func setupConstraints() {
        quizTitle.topAnchor.constraint(equalTo:self.topAnchor, constant: 40).isActive = true
        quizTitle.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        quizTitle.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        quizTitle.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        quizImage.topAnchor.constraint(equalTo:quizTitle.bottomAnchor, constant: 10).isActive = true
        quizImage.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        quizImage.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        quizImage.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        startButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        startButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        startButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        startButton.topAnchor.constraint(equalTo:quizImage.bottomAnchor, constant:30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
