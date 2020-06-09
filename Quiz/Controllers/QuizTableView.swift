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
    var tableViewData = [Category: [Quiz]]()

    init(_ tv: UITableView, _ data: [Category: [Quiz]]){
        tableViewData = data
        quizTableView = tv
        super.init()
        quizTableView.dataSource = self
        
        quizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
        quizTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[Global.categorySections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        let currentQuiz = tableViewData[Global.categorySections[indexPath.section]]![indexPath.row]
        cell.selectionStyle = .none
        cell.quizTitle.text = currentQuiz.title
        cell.quizImage.image = setImage(imageURL: currentQuiz.image) ?? UIImage()
        cell.quizDescription.text = currentQuiz.description
        cell.setLevelImage(level: currentQuiz.level, color: Global.sectionColors[indexPath.section])
        return cell
    }
    
    private func setImage(imageURL: URL) -> UIImage? {
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Global.categorySections[section].rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Global.categorySections.count
    }
    
}


