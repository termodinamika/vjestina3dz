//
//  QuizInfoViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    var quiz: Quiz?
    let quizView = QuizView()
    var nextQuestion = 0
    var noCorrectAnswers = 0
    var quizStartedAt: TimeInterval!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuizUI()
        setupConstraints()
        setupEvents()
    }
    
    func setQuiz(with quiz: Quiz) {
        self.quiz = quiz
    }
    
    @objc func startPressed(_ sender: UIButton) {
        quizStartedAt = Date.timeIntervalSinceReferenceDate
        let questionView = QuestionViewController()
        guard let quiz = quiz else { return }
        
        questionView.setQuizParams(quiz, quizStartedAt)
        navigationController?.pushViewController(questionView, animated: true)
    }
    
    @objc func leaderboardPressed(_ sender: UIButton) {
        let nextViewController = LeaderboardViewController()
        guard let quiz = quiz else { return }
        
        nextViewController.setQuizId(id: quiz.id)
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func backButtonPressed(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    func setupEvents() {
        quizView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        quizView.startButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
        quizView.leaderboardButton.addTarget(self, action: #selector(leaderboardPressed), for: .touchUpInside)
    }
    
    func setupQuizUI() {
        guard let quiz = quiz else { return }
        view.backgroundColor = .systemIndigo
        quizView.quizTitle.text = quiz.title
        quizView.quizImage.image = Utils.setImage(imageURL: quiz.image)
        quizView.quizDescription.text = quiz.description
        quizView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(quizView)
    }
    
    func setupConstraints() {
        quizView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        quizView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        quizView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        quizView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
}
