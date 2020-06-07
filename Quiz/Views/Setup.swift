//
//  Setup.swift
//  Quiz
//
//  Created by Lucija Balja on 06/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class Setup {
    
    static func setTableView(_ tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemIndigo
        tableView.separatorStyle = .none
        tableView.rowHeight = 143.0
    }
    
    static func setAnswerButtonView(_ answer: UIButton) {
        answer.backgroundColor = .systemIndigo
        answer.tintColor = .white
        answer.layer.cornerRadius = 5
        answer.clipsToBounds = true
        answer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func setTextField(_ textField: UITextField, size: CGFloat = 20.0, isBold: Bool = true, backgroundColor: UIColor = .white, placeholder: String) {
        textField.font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        textField.alpha = 0.5
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.white.cgColor
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = 20
        textField.placeholder = placeholder
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func setButton(_ button: UIButton, size: CGFloat = 20.0, isBold: Bool = true, title: String) {
        button.titleLabel?.font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.alpha = 0.9
        button.tintColor = .systemIndigo
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    static func setLabel(_ label: UILabel, size: CGFloat = 20.0, isBold: Bool = true, text: String = "") {
        label.font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
