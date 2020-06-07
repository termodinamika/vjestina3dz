//
//  QuizListViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 29/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit
import Reachability

class QuizListViewController: UIViewController {
    let quizService = QuizService()
    let quizInfoView = QuizInfoView()
    let dataService = CoreDataService()
    var quizzes: [Quiz] = []
    var categorizedQuizzes = [Category: [Quiz]](){
        didSet{
            initTableView()
        }
    }
    var tableViewController: QuizTableView!
    var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        setupUI()
        setupEvents()
        setupTableConstraints()
    }
    
    func initTableView() {
        tableViewController = QuizTableView(tableView, categorizedQuizzes)
    }
    
    func fetchData(){
        dataService.loadQuizzes { (quizData) in
            guard let quizData = quizData else {
                self.fetchFromApi()
                return
            }
            DispatchQueue.main.async {
                self.quizzes.append(contentsOf: self.dataService.convertQuizData(quizData))
                self.quizzes = self.quizzes.uniqueElements()
                self.categorizedQuizzes = Utils.categorySorting(self.quizzes)
                self.tableView.reloadData()
            }
        }
        //fetchFromApi()
    }
    
    func fetchFromApi(){
        quizService.fetchQuizzes(){
            (status, quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes.quizzes
                    self.saveQuizzesToCoreData()
                    self.categorizedQuizzes = Utils.categorySorting(self.quizzes)
                    self.tableView.reloadData()
                } else if !status {
                    self.quizInfoView.setErrorLabel()
                }
            }
        }
    }
    
    func saveQuizzesToCoreData() {
        for quiz in quizzes {
            dataService.prepareData(quiz: quiz)
        }
    }
    
    func setupEvents() {
        quizInfoView.getQuizButton.addTarget(self, action: #selector(dohvatiButtonClicked), for: .touchUpInside)
    }
    
    @objc func dohvatiButtonClicked(_ sender: UIButton) {
        fetchData()
        DispatchQueue.main.async {
            if self.quizzes.count == 0 {
                self.quizInfoView.errorLabel.isHidden = false
                return
            }
            var counter = 0
            for quiz in self.quizzes {
                let nbaArray = quiz.questions.filter({
                    (value: Question) -> Bool in
                    return value.question.contains("NBA")
                })
                counter += nbaArray.count
            }
            self.quizInfoView.funFactLabel.text = "There are \(counter) questions containing word NBA"
        }
        
    }
    
    private func setupUI() {
        view.addSubview(quizInfoView)
        quizInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        Setup.setTableView(tableView)
        view.addSubview(tableView)
    }
    
    private func setupTableConstraints() {
        quizInfoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        quizInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quizInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        quizInfoView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        tableView.topAnchor.constraint(equalTo: quizInfoView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
