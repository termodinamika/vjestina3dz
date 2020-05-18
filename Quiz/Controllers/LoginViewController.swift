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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginDelegate = self
        
        setupUI()
        setupConstraints()
    }
    
    func onLoginPressed(username: String, password: String) {
        let nextViewController = QuizListViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        
        loginService.loginUser(username: username, password: password, completion: {
            (status, loginResponse) in
            DispatchQueue.main.async {
                if status == true {
                    UserDefaults.standard.set(loginResponse?.token, forKey: "userToken")
                    UserDefaults.standard.set(loginResponse?.user_id, forKey: "userID")
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else {
                    self.loginView.errorLabel.text = "Error trying to log in. Try again."
                    self.loginView.errorLabel.isHidden = false
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
