//
//  QuizListViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 29/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizListViewController: UIViewController {
    
    let quizService = QuizService()
    let quizInfoView = QuizListView()
    var quizzes: [Quiz] = []
    var categorySections = Category.allCases
    var data = [Int: [Quiz]]()
    var sectionColors: [UIColor] = [.systemYellow, .systemBlue, .systemTeal,  .systemPink]
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        quizInfoView.tableView.dataSource = self
        quizInfoView.tableView.delegate = self
        quizInfoView.tableView.isHidden = true
        
        fetchData()
        setupUI()
        setupEvents()
        setupTableConstraints()
        setupTableCell()
    }
    
    func fetchData(){
        quizService.fetchQuizzes(){
            (status, quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes.quizzes
                    for i in 0...self.categorySections.count - 1 {
                        self.data[i] = quizzes.quizzes.filter({ (quiz) in
                            return quiz.category == self.categorySections[i]
                        })
                    }
                    self.quizInfoView.tableView.reloadData()
                } else if status == false {
                    self.quizInfoView.tableView.isHidden = true
                    self.quizInfoView.errorLabel.isHidden = false
                    self.quizInfoView.errorLabel.text = "Error fetching data!"
                }
            }
        }
    }
    
    func setupEvents() {
        quizInfoView.getQuizButton.addTarget(self, action: #selector(dohvatiButtonClicked), for: .touchUpInside)
    }
    
    private func setupTableCell(){
        quizInfoView.tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
    }
    
    @objc func dohvatiButtonClicked(_ sender: UIButton) {
        var counter = 0
        if quizzes.count != 0 {
            quizInfoView.errorLabel.isHidden = true
            quizInfoView.tableView.isHidden = false
            for quiz in quizzes {
                let nbaArray = quiz.questions.filter({
                    (value: Question) -> Bool in
                    return value.question.contains("NBA")
                })
                counter += nbaArray.count
            }
            quizInfoView.funFactLabel.text = "There are \(counter) questions containing word NBA"
        }
    }
    
    private func setupUI() {
        view.addSubview(quizInfoView)
        quizInfoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableConstraints() {
        quizInfoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        quizInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quizInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        quizInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension QuizListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizInfoView.tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        let currentQuiz = data[indexPath.section]![indexPath.row]
        cell.selectionStyle = .none
        cell.quizTitle.text = currentQuiz.title
        cell.quizImage.image = setImage(imageURL: currentQuiz.image) ?? UIImage()
        cell.quizDescription.text = currentQuiz.description
        cell.setLevelImage(level: currentQuiz.level, color: sectionColors[indexPath.section])
        return cell
    }
    
    private func setImage(imageURL: URL) -> UIImage? {
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorySections[section].rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorySections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.textColor = sectionColors[section]
        
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        sectionLabel.text = categorySections[section].rawValue
        return sectionLabel
    }
}

extension QuizListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuiz = data[indexPath.section]?[indexPath.row]
        let nextViewController = QuizViewController()
        
        nextViewController.setQuiz(with: selectedQuiz!)
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
