//
//  TableViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 06/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class QuizTableView: NSObject, UITableViewDataSource, UITableViewDelegate {
    var categorySections = Category.allCases
    var sectionColors: [UIColor] = [.systemYellow, .systemBlue, .systemTeal,  .systemPink]
    var quizTableView: UITableView
    var tableViewData = [Category: [Quiz]]()
    
    init(_ tv: UITableView, _ data: [Category: [Quiz]]){
        tableViewData = data
        quizTableView = tv
        super.init()
        quizTableView.delegate = self
        quizTableView.dataSource = self
        quizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
        quizTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[categorySections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        let currentQuiz = tableViewData[categorySections[indexPath.section]]![indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuiz = tableViewData[categorySections[indexPath.section]]?[indexPath.row]
        let nextViewController = QuizViewController()
        
        nextViewController.setQuiz(with: selectedQuiz!)
        nextViewController.modalPresentationStyle = .fullScreen
        // self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}


