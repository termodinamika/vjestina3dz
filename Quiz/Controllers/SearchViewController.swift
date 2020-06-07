//
//  SearchViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

protocol SearchDelegate {
    func onSearchPressed(searchWord: String)
}

class SearchViewController: UIViewController, SearchDelegate {
    
    let searchView = SearchView()
    let dataService = CoreDataService()
    var quizzes: [Quiz] = []
    var categorizedQuizzes = [Category: [Quiz]]() {
        didSet {
            initTableView()
        }
    }
    var tableViewController: QuizTableView!
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        searchView.searchDelegate = self
    }
    
    func onSearchPressed(searchWord: String) {
        dataService.loadQuizzes(with: searchWord, completion: { (quizData) in
            guard let quizData = quizData else {
                print("No quizes found with given search word")
                return
            }
            self.quizzes = self.dataService.convertQuizData(quizData)
            self.categorizedQuizzes = Utils.categorySorting(self.quizzes)
        })
    }
    
    func initTableView() {
        tableViewController = QuizTableView(tableView, categorizedQuizzes)
        tableView.isHidden = false
    }
    
    func setupUI() {
        view.backgroundColor = .systemIndigo
        searchView.translatesAutoresizingMaskIntoConstraints = false
        Setup.setTableView(tableView)
        
        view.addSubview(searchView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        searchView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
