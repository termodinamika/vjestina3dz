//
//  LoginViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 28/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func onLoginPressed(username: String, password: String)
}

class LoginViewController: UIViewController, LoginDelegate {
    var loginView = LoginView()
    var loginService = LoginService()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginDelegate = self
        
        setupUI()
        setupConstraints()
    }
    
    func onLoginPressed(username: String, password: String) {
        let nextViewController = TabBarController()
        nextViewController.modalPresentationStyle = .fullScreen
        
        loginService.loginUser(username: username, password: password, completion: {
            (isSuccessful, loginResponse) in
            DispatchQueue.main.async {
                if isSuccessful {
                    guard let token = loginResponse?.token, let userID = loginResponse?.userID else { return }
                    DataService.saveUserParams(username: username, token: token, userID: userID)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else {
                    self.loginView.setErrorLabel(text: "Error trying to log in. Try again.")
                }
            }
        })
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray2
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
}
