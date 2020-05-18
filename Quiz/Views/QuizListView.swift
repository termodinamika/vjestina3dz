//
//  QuizInfoView.swift
//  Quiz
//
//  Created by Lucija Balja on 27/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizListView: UIView {
    
    var getQuizButton = UIButton(type: .system)
    var funFactTitle = UILabel()
    var funFactLabel = UILabel()
    var appLabel = UILabel()
    var errorLabel = UILabel()
    var tableView = UITableView()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        setupAutoLayout()
    }
    
    func setupQuizUI(counter: Int, quiz: Quiz){
        funFactLabel.text = String("There are \(counter) questions with NBA")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemIndigo
        
        appLabel.font = UIFont(name: "AvenirNext-Bold", size: 32.0)
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        appLabel.text = "PopQuiz"
        appLabel.textColor = .white
        appLabel.textAlignment = .center
        
        getQuizButton.backgroundColor = .white
        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        getQuizButton.tintColor = .systemIndigo
        getQuizButton.layer.cornerRadius = 20
        getQuizButton.clipsToBounds = true
        getQuizButton.translatesAutoresizingMaskIntoConstraints = false
        
        funFactTitle.font = UIFont(name: "AvenirNext-Bold", size: 25.0)
        funFactTitle.translatesAutoresizingMaskIntoConstraints = false
        funFactTitle.text = "💡 Fun Fact"
        funFactTitle.textColor = .white
        funFactTitle.textAlignment = .center
        
        funFactLabel.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        funFactLabel.translatesAutoresizingMaskIntoConstraints = false
        funFactLabel.numberOfLines = 0
        funFactLabel.lineBreakMode = .byWordWrapping
        funFactLabel.textColor = .white
        funFactLabel.textAlignment = .center

        errorLabel.font = UIFont(name: "AvenirNext-Bold", size: 25.0)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .white
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemIndigo
        tableView.separatorStyle = .none
        tableView.rowHeight = 143.0
      
        addSubview(appLabel)
        addSubview(getQuizButton)
        addSubview(funFactTitle)
        addSubview(funFactLabel)
        addSubview(errorLabel)
        addSubview(tableView)
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
        
          tableView.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: 30).isActive = true
          tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
          tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
          tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
