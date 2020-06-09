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
    var quizTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        searchView.searchDelegate = self
        quizTableView.delegate = self
    }
    
    func initTableView() {
        tableViewController = QuizTableView(quizTableView, categorizedQuizzes)
        quizTableView.isHidden = false
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
    
    func setupUI() {
        view.backgroundColor = .systemIndigo
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        Setup.setTableView(quizTableView)
        quizTableView.isHidden = true
        
        view.addSubview(searchView)
        view.addSubview(quizTableView)
    }
    
    func setupConstraints() {
        searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        searchView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        quizTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 30).isActive = true
        quizTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quizTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        quizTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension SearchViewController: UITableViewDelegate {
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
