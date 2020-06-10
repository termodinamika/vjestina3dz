//
//  TableViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 06/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class QuizTableView: NSObject, UITableViewDataSource {
    var quizTableView: UITableView!
    var tableViewData: [CategorizedQuizzes] = []

    init(_ tv: UITableView, _ data: [CategorizedQuizzes]){
        super.init()
        tableViewData = data
        quizTableView = tv
        quizTableView.dataSource = self
        
        quizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
        quizTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        let currentQuiz = tableViewData[indexPath.section].quizzes[indexPath.row]
        cell.quizTitle.text = currentQuiz.title
        cell.quizImage.image = Utils.setImage(imageURL: currentQuiz.image)
        cell.quizDescription.text = currentQuiz.description
        cell.setLevelImage(level: currentQuiz.level, color: Global.sectionColors[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].category.rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
}


