//
//  QuizInfoView.swift
//  Quiz
//
//  Created by Lucija Balja on 27/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizInfoView: UIView {
    var getQuizButton = UIButton(type: .system)
    var funFactTitle = UILabel()
    var funFactLabel = UILabel()
    var appLabel = UILabel()
    var errorLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        setupAutoLayout()
    }
    
    func setupQuizUI(counter: Int, quiz: Quiz){
        funFactLabel.text = String("There are \(counter) questions with NBA")
    }
    
    func setErrorLabel() {
        errorLabel.isHidden = false
        errorLabel.text = "Error fetching data!"
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemIndigo
        
        Setup.setLabel(appLabel, size: 32.0, text: "PopQuiz")
        Setup.setButton(getQuizButton, title: "Get Quiz")
        Setup.setLabel(funFactTitle, size: 25.0, text: "💡 Fun Fact")
        Setup.setLabel(funFactLabel, isBold: false)
        Setup.setLabel(errorLabel, size: 25.0)
        
        funFactLabel.numberOfLines = 0
        funFactLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
        
        addSubview(appLabel)
        addSubview(getQuizButton)
        addSubview(funFactTitle)
        addSubview(funFactLabel)
        addSubview(errorLabel)
    }
    
    private func setupAutoLayout() {
        appLabel.topAnchor.constraint(equalTo:self.topAnchor, constant: 40).isActive = true
        appLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        appLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        getQuizButton.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        getQuizButton.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        getQuizButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        getQuizButton.topAnchor.constraint(equalTo:appLabel.bottomAnchor, constant:10).isActive = true
        
        funFactTitle.topAnchor.constraint(equalTo:getQuizButton.bottomAnchor, constant: 20).isActive = true
        funFactTitle.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        funFactTitle.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        funFactTitle.heightAnchor.constraint(equalToConstant:30).isActive = true
        
        funFactLabel.topAnchor.constraint(equalTo:funFactTitle.bottomAnchor, constant: 20).isActive = true
        funFactLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        funFactLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        funFactLabel.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo:funFactLabel.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
