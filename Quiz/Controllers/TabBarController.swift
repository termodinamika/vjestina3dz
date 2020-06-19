//
//  TabBarController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var window: UIWindow?
    
    init(with window: UIWindow) {
        super.init(nibName: nil, bundle: nil)
        self.window = window
        setTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTabBar() {
        let quizVc = QuizListViewController()
        let searchVc = SearchViewController()
        guard let safeWindow = self.window else { return }
        let settingsVc = SettingsViewController(with: safeWindow)
        
        quizVc.tabBarItem = UITabBarItem(title: "Quiz", image:  UIImage(systemName: "stopwatch"), tag: 0)
        searchVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        settingsVc.tabBarItem = UITabBarItem(title: "Settings", image:  UIImage(named: "settings"), tag: 2)
        let quizNavigationController = UINavigationController(rootViewController: quizVc)
        let searchNavigationController = UINavigationController(rootViewController: searchVc)
        
        self.viewControllers = [quizNavigationController, searchNavigationController, settingsVc]
        self.selectedViewController = quizNavigationController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
