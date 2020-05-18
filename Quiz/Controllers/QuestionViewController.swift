//
//  ViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var question: Question!
    var questionView: QuestionView!
    let quizService = QuizService()

    override func viewDidLoad() {
        super.viewDidLoad()
        questionView = QuestionView()

        setupUIView()
        setupConstraints()
    }
    
    func setupUIView() {
        view.backgroundColor = .systemGray2
    
        questionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionView)
    }
    
    func setupConstraints() {
        questionView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        questionView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        questionView.topAnchor.constraint(equalTo:view.bottomAnchor, constant:2).isActive = true
        questionView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true        
    }
}
