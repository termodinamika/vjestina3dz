//
//  QuizInfoViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

protocol AnswerCheckerDelegate {
    func checkAnswer(_ isCorrect: Bool)
}

class QuizViewController: UIViewController, AnswerCheckerDelegate {
    var quiz: Quiz!
    let leaderboardButton = UIButton(type: .system)
    let quizView = QuizView()
    let questionView = QuestionView()
    let quizService = QuizService()
    var nextQuestion = 0
    var noCorrectAnswers = 0
    var quizStartedAt: TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionView.delegate = self
        setupQuizUI()
        setupConstraints()
        setupEvents()
    }
    
    func checkAnswer(_ isCorrect: Bool) {
        if isCorrect { noCorrectAnswers += 1 }
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.nextQuestion += 1
            self.setNextQuestion()
        }
    }
    
    func setQuiz(with quiz: Quiz) {
        self.quiz = quiz
    }
    
    @objc func startPressed(_ sender: UIButton) {
        quizStartedAt = Date.timeIntervalSinceReferenceDate
        setNextQuestion()
    }
    
    @objc func leaderboardPressed(_ sender: UIButton) {
        let nextViewController = LeaderboardViewController()
        nextViewController.setQuizId(id: quiz.id)
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func setNextQuestion() {
        if nextQuestion < quiz.questions.count {
            questionView.setupQuestionUI(with: quiz.questions[nextQuestion])
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
    
    func setupEvents() {
        quizView.startButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
        leaderboardButton.addTarget(self, action: #selector(leaderboardPressed), for: .touchUpInside)
    }
    
    func setupQuizUI() {
        view.backgroundColor = .systemIndigo
        quizView.quizTitle.text = quiz.title
        quizView.setImage(imageURL: quiz.image)
        
        leaderboardButton.setTitle("Leaderboard", for: .normal)
        leaderboardButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        leaderboardButton.tintColor = .white
        leaderboardButton.clipsToBounds = true
        
        leaderboardButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leaderboardButton)
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionView)
    }
    
    func setupConstraints() {        
        leaderboardButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        leaderboardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leaderboardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        quizView.topAnchor.constraint(equalTo: leaderboardButton.bottomAnchor, constant: 20).isActive = true
        quizView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        quizView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        quizView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        questionView.topAnchor.constraint(equalTo: quizView.bottomAnchor).isActive = true
        questionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        questionView.heightAnchor.constraint(equalToConstant: view.frame.height/1.5).isActive = true
        questionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
