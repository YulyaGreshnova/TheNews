//
//  AppDelegate.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 08.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let newsListViewController = NewsListAssembly().buildViewController()
        let navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

