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
    var quizTableView = UITableView()
    let reachability = try! Reachability()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        setupUI()
        setupConstraints()
        quizTableView.delegate = self
        
        quizInfoView.getQuizButton.addTarget(self, action: #selector(getQuizClicked), for: .touchUpInside)
    }
    
    @objc func getQuizClicked(_ sender: UIButton) {
        checkReachability()
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
            self.quizInfoView.funFactLabel.text = "There are \(counter) questions containing word NBA"
        }
        }
    }
    
    func checkReachability() {
        reachability.whenReachable = { reachability in
            print("it is reachable")
            self.loadData()
            self.fetchFromApi()
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.loadData()
        }
        print(reachability.connection.description)
    }
    
    func loadData(){
        dataService.loadQuizzes { (quizData) in
            guard let quizData = quizData else { return }
            self.quizzes.append(contentsOf: self.dataService.convertQuizData(quizData))
            self.quizzes = self.quizzes.uniqueElements()
            
            DispatchQueue.main.async { self.quizTableView.reloadData() }
        }
    }
    
    func fetchFromApi(){
        quizService.fetchQuizzes(){
            (status, quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.saveNewQuizzes(quizzes.quizzes)
                    self.quizTableView.reloadData()
                } else if !status {
                    self.quizInfoView.setErrorLabel()
                }
            }
        }
    }
    
    func saveNewQuizzes(_ quizArray: [Quiz]) {
        let newQuizzes = quizzes.difference(from: quizArray)
        for quiz in newQuizzes {
            dataService.prepareData(quiz: quiz)
        }
        quizzes.append(contentsOf: newQuizzes)
        categorizedQuizzes = Utils.categorySorting(quizzes)
    }
    
    func initTableView() {
        tableViewController = QuizTableView(quizTableView, categorizedQuizzes)
        quizTableView.isHidden = false        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemIndigo
        view.addSubview(quizInfoView)
        quizInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        quizTableView.isHidden = true
        Setup.setTableView(quizTableView)
        view.addSubview(quizTableView)
    }
    
    private func setupConstraints() {
        quizInfoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        quizInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quizInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        quizInfoView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        quizTableView.topAnchor.constraint(equalTo: quizInfoView.bottomAnchor).isActive = true
        quizTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quizTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        quizTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension QuizListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.textColor = Global.sectionColors[section]
        
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        sectionLabel.text = Global.categorySections[section].rawValue
        return sectionLabel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedQuiz = categorizedQuizzes[Global.categorySections[indexPath.section]]?[indexPath.row] else { return }
        let nextViewController = QuizViewController()
        nextViewController.setQuiz(with: selectedQuiz)
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
