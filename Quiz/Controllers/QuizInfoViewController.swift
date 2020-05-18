//
//  QuizInfoViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var questions: [Question] = []
    //let quizInfoView = QuizInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollUI()
        setQuestions()
    }
    
    func setQuestions() {
        for question in questions {
            let questionView = QuestionView()
            questionView.setupQuestionUI(with: question)
            self.stackView.addArrangedSubview(questionView)
        }
    }
    
    func setScrollUI(){
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor).isActive = true
        
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        stackView.spacing = 10
    }
    
    func setQuiz(with quiz: Quiz) {
        questions = quiz.questions
        
    }
}
