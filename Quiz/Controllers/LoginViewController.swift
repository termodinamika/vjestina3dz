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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            self.loginView.appLabel.alpha = 1.1
            self.loginView.appLabel.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }) { _ in
        }
        UIView.animate(withDuration: 1, delay: 0.1, options: UIView.AnimationOptions.curveLinear, animations: {
            self.loginView.usernameTextField.alpha = 1.1
            self.loginView.usernameTextField.center = CGPoint(x: 200, y: 200)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, options: UIView.AnimationOptions.curveLinear, animations: {
            self.loginView.passwordTextField.alpha = 1.1
            self.loginView.passwordTextField.center = CGPoint(x: 200, y: 270)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: UIView.AnimationOptions.curveLinear, animations: {
            self.loginView.loginButton.alpha = 1.1
            self.loginView.loginButton.center = CGPoint(x: 200, y: 340)
        }, completion: nil)
        
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
        loginView.appLabel.alpha = 0.0
        loginView.usernameTextField.alpha = 0.0
        loginView.passwordTextField.alpha = 0.0
    }
    
    func setupConstraints() {
        loginView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
}
