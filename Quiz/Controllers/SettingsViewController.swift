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
    var window: UIWindow?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupEvents()
        getUsername()
    }
    
    init(with window: UIWindow) {
        super.init(nibName: nil, bundle: nil)
        self.window = window
    }
    
    func getUsername() {
        let username = UserDefaults.standard.string(forKey: "username") ?? "default-username"
        settingsView.usernameLabel.text = username
    }
    
    func setupEvents() {
        settingsView.logoutButton.addTarget(self, action: #selector(onLogoutPressed), for: .touchUpInside)
    }
    
    @objc func onLogoutPressed() {
        DataService.removeUserParams()
        guard let safeWindow = self.window else { return }
        safeWindow.rootViewController = LoginViewController(with: safeWindow)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
