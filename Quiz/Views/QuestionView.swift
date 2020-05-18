//
//  QuestionView.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    var questionLabel = UILabel()
    var answer1 = UIButton(type: .system)
    var answer2 = UIButton(type: .system)
    var answer3 = UIButton(type: .system)
    var answer4 = UIButton(type: .system)
    var question: Question!
    var delegate: AnswerCheckerDelegate!
    
    init() {
        super.init(frame: CGRect.zero)
        setupEvents()
    }
    
    func setupEvents() {
         answer1.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
         answer2.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
         answer3.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
         answer4.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)
     }
    
    @objc func answerClicked(_ sender: UIButton) {
        var isCorrect = false
        if question.correct_answer == sender.tag {
            isCorrect = true
        }
        switch sender.tag {
        case 0:
            answer1.backgroundColor = isCorrect ? .green : .red
            fireTimer(button: answer1)
        case 1:
            answer2.backgroundColor = isCorrect ? .green : .red
            fireTimer(button: answer2)
        case 2:
            answer3.backgroundColor = isCorrect ? .green : .red
            fireTimer(button: answer3)
        case 3:
            answer4.backgroundColor = isCorrect ? .green : .red
            fireTimer(button: answer4)
        default:
            print("Wrong index is given.")
        }
        self.delegate?.checkAnswer(isCorrect)
    }
    
    func setupQuestionUI(with question: Question) {
        self.question = question
        initView()
        setupConstraints()
    }

    func fireTimer(button: UIButton) {
        DispatchQueue.main.async {
            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                button.backgroundColor = .systemIndigo
            }
        }
    }
    
    private func initView() {
        backgroundColor = .systemIndigo
        
        questionLabel.backgroundColor = .gray
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.textColor = .white
        questionLabel.textAlignment = .center
        questionLabel.isHidden = false
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.text = question.question
        
        answer1.backgroundColor = .systemIndigo
        answer1.setTitle(question.answers[0], for: .normal)
        answer1.tintColor = .white
        answer1.layer.cornerRadius = 5
        answer1.clipsToBounds = true
        answer1.translatesAutoresizingMaskIntoConstraints = false
        answer1.tag = 0
        
        answer2.backgroundColor = .systemIndigo
        answer2.setTitle(question.answers[1], for: .normal)
        answer2.tintColor = .white
        answer2.layer.cornerRadius = 5
        answer2.clipsToBounds = true
        answer2.translatesAutoresizingMaskIntoConstraints = false
        answer2.tag = 1
        
        answer3.backgroundColor = .systemIndigo
        answer3.setTitle(question.answers[2], for: .normal)
        answer3.tintColor = .white
        answer3.layer.cornerRadius = 5
        answer3.clipsToBounds = true
        answer3.translatesAutoresizingMaskIntoConstraints = false
        answer3.tag = 2
        
        answer4.backgroundColor = .systemIndigo
        answer4.setTitle(question.answers[3], for: .normal)
        answer4.tintColor = .white
        answer4.layer.cornerRadius = 5
        answer4.clipsToBounds = true
        answer4.translatesAutoresizingMaskIntoConstraints = false
        answer4.tag = 3
        
        addSubview(questionLabel)
        addSubview(answer1)
        addSubview(answer2)
        addSubview(answer3)
        addSubview(answer4)
    }
    
    private func setupConstraints() {
        questionLabel.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        questionLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant:100).isActive = true
        questionLabel.topAnchor.constraint(equalTo:self.topAnchor, constant:10).isActive = true
        
        answer1.topAnchor.constraint(equalTo:questionLabel.bottomAnchor, constant: 20).isActive = true
        answer1.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        answer1.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        answer1.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        answer2.topAnchor.constraint(equalTo:answer1.bottomAnchor, constant: 20).isActive = true
        answer2.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        answer2.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        answer2.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        answer3.topAnchor.constraint(equalTo:answer2.bottomAnchor, constant: 20).isActive = true
        answer3.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        answer3.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        answer3.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        answer4.topAnchor.constraint(equalTo:answer3.bottomAnchor, constant: 20).isActive = true
        answer4.leftAnchor.constraint(equalTo:self.leftAnchor, constant:20).isActive = true
        answer4.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-20).isActive = true
        answer4.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
