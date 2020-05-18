//
//  SceneDelegate.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    var tabBarViewController = UITabBarController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        if UserDefaults.standard.string(forKey: "userID") != nil {
            navigationController = UINavigationController(rootViewController: QuizListViewController())
            let quizVc = navigationController
            let leaderboardVc = SearchViewController()
            let settingsVc = SettingsViewController()
            
            quizVc.tabBarItem = UITabBarItem(title: "Quiz", image:  UIImage(systemName: "stopwatch"), tag: 0)
            leaderboardVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
            settingsVc.tabBarItem = UITabBarItem(title: "Settings", image:  UIImage(named: "settings"), tag: 2)
            let tabBarList = [quizVc, leaderboardVc, settingsVc]
            tabBarViewController.viewControllers = tabBarList
        } else {
            navigationController = UINavigationController(rootViewController: LoginViewController())
        }
        
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

