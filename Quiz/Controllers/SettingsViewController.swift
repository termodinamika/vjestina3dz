//
//  SettingsViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settingsView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .systemIndigo
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(settingsView)
    }
    
    func setupConstraints() {
        settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        settingsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        settingsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

    }

}
