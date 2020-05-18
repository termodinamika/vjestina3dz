//
//  TabBarController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstVc = QuizListViewController()
        let secondVc = LeaderboardViewController()
        let thirdVc = SettingsViewController()
        
        firstVc.tabBarItem = UITabBarItem(title: "Quiz", image:  UIImage(systemName: "stopwatch"), tag: 0)
        secondVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        thirdVc.tabBarItem = UITabBarItem(title: "Settings", image:  UIImage(named: "settings"), tag: 2)
        let tabBarList = [firstVc, secondVc, thirdVc]
        viewControllers = tabBarList

    }
    
}
