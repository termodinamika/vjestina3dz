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
        let navigation = UINavigationController(rootViewController: QuizListViewController())
        let leaderboardVc = SearchViewController()
        let settingsVc = SettingsViewController()
        
        navigation.tabBarItem = UITabBarItem(title: "Quiz", image:  UIImage(systemName: "stopwatch"), tag: 0)
        leaderboardVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        settingsVc.tabBarItem = UITabBarItem(title: "Settings", image:  UIImage(named: "settings"), tag: 2)
        let tabBarList = [navigation, leaderboardVc, settingsVc]
        self.viewControllers = tabBarList
    }
}
