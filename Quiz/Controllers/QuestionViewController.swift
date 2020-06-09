//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 08/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

protocol AnswerCheckerDelegate {
    func checkAnswer(_ isCorrect: Bool)
}

class QuestionViewController: UIViewController, AnswerCheckerDelegate {
    let quizService = QuizService()
    var nextQuestion = 0
    var noCorrectAnswers = 0
    var quizStartedAt: Double = 0.0
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var appLabel = UILabel()
    var quiz: Quiz! {
        didSet{
            setQuestionsToScrollView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        setupUI()
        setupConstraints()
    }
    
    func checkAnswer(_ isCorrect: Bool) {
        if isCorrect { noCorrectAnswers += 1 }
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.nextQuestion += 1
            self.setNextQuestion()
        }
    }
    
    func setQuizParams(_ quiz: Quiz,_ quizStartedAt: TimeInterval) {
        self.quiz = quiz
        self.quizStartedAt = quizStartedAt
    }
    
    func setQuestionsToScrollView() {
        for question in quiz.questions {
            let questionView = QuestionView()
            questionView.delegate = self
            questionView.setupQuestionUI(with: question)
            
            questionView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(questionView)
            
            questionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            questionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
    }
    
    func setNextQuestion() {
        if nextQuestion < quiz.questions.count {
            let offset = nextQuestion * Int(scrollView.bounds.width)
            UIView.animate(withDuration: 0.33, animations: { [weak self] in
                self?.scrollView.contentOffset.x = CGFloat(offset)
            })
        } else {
            let timeTaken = Date.timeIntervalSinceReferenceDate - quizStartedAt
            
            quizService.sendResults(noCorrectAnswers: noCorrectAnswers, timeTaken: timeTaken, quizId: quiz.id) { (result) in
                DispatchQueue.main.async {
                    if result == ServerResponse.SUCCESS.rawValue {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("Sending quiz data not successfull :( ")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemIndigo
        Setup.setLabel(appLabel, size: 32.0, text: "PopQuiz")

        scrollView.addSubview(self.stackView)
        view.addSubview(scrollView)
        view.addSubview(appLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
    }
    
    func setupConstraints() {
        appLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: 40).isActive = true
        appLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        appLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: self.appLabel.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
    }
}
