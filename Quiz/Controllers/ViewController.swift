//
//  ViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var quizzes: [Quiz]!
    var questionView: QuestionView!
    var quizInfoView: QuizInfoView!
    let quizService = QuizService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        quizInfoView = QuizInfoView()
        questionView = QuestionView()

        setupUIView()
        setupConstraints()
        setupEvents()
    }
    
    func fetchData(){
        quizService.fetchQuizzes(){ (quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes.quizzes
                }
            }
        }
    }
    
    func setupUIView() {
        view.backgroundColor = .systemGray2
    
        quizInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizInfoView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionView)
    }
    
    func setupConstraints() {
        quizInfoView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        quizInfoView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        quizInfoView.topAnchor.constraint(equalTo:view.topAnchor, constant:50).isActive = true
        quizInfoView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        
        questionView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        questionView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        questionView.topAnchor.constraint(equalTo:quizInfoView.bottomAnchor, constant:2).isActive = true
        questionView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
    }
    
    
    func setupEvents(){
        
        questionView.answer1.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
        questionView.answer2.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
        questionView.answer3.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
        questionView.answer4.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
    }
    
    @objc func answerClicked(_ sender: UIButton) {
        questionView.answerClicked(index: sender.tag)
    }

    }
    
    func setupQuizInfo(counter: Int){
        quizInfoView.setupQuizUI(counter: counter, quiz: quizzes[0])
        questionView.setupQuestionUI(question: quizzes[0].questions[0])
    }
}

