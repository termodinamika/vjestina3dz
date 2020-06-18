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
    var window: UIWindow?
    var loginView = LoginView()
    var loginService = LoginService()
    
    init(with window: UIWindow) {
        super.init(nibName: nil, bundle: nil)
        self.window = window
    }
    
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
        setInAnimations()
    }
    
    func onLoginPressed(username: String, password: String) {
        loginService.loginUser(username: username, password: password, completion: {
            (isSuccessful, loginResponse) in
            DispatchQueue.main.async {
                if isSuccessful {
                    self.setOutAnimations()
                    guard let token = loginResponse?.token, let userID = loginResponse?.userID else { return }
                    DataService.saveUserParams(username: username, token: token, userID: userID)
                } else {
                    self.loginView.setErrorLabel(text: "Error trying to log in. Try again.")
                }
            }
        })
    }
    
    func setInAnimations() {
        let xPosition = self.view.frame.width/2
        let yPosition = self.view.frame.height/3
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            self.loginView.appLabel.alpha = 1.1
            self.loginView.appLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.loginView.usernameTextField.alpha = 1.1
            self.loginView.usernameTextField.center = CGPoint(x: xPosition, y: yPosition)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {
            self.loginView.passwordTextField.alpha = 1.1
            self.loginView.passwordTextField.center = CGPoint(x: xPosition, y: yPosition + 70)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseOut, animations: {
            self.loginView.loginButton.alpha = 1.1
            self.loginView.loginButton.center = CGPoint(x: xPosition, y: yPosition + 140)
        }, completion: nil)
    }
    
    func setOutAnimations() {
        let xPosition = self.view.frame.width/2
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
            self.loginView.appLabel.alpha = 0.0
            self.loginView.appLabel.center = CGPoint(x: xPosition, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.loginView.usernameTextField.alpha = 0.0
            self.loginView.usernameTextField.center = CGPoint(x: xPosition, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {
            self.loginView.passwordTextField.alpha = 0.0
            self.loginView.passwordTextField.center = CGPoint(x: xPosition, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseOut, animations: {
            self.loginView.loginButton.alpha = 0.0
            self.loginView.loginButton.center = CGPoint(x: xPosition, y: 0)
        }, completion: nil)
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            guard let safeWindow = self.window else { return }
            let tabBarController = TabBarController(with: safeWindow)
            tabBarController.modalPresentationStyle = .fullScreen
            safeWindow.rootViewController = tabBarController
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray2
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        loginView.appLabel.alpha = 0.0
        loginView.appLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        loginView.usernameTextField.alpha = 0.0
        loginView.passwordTextField.alpha = 0.0
    }
    
    func setupConstraints() {
        loginView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
