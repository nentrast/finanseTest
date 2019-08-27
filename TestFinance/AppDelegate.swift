//
//  AppDelegate.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let stockVC = SceneFactory.stockActivesScene()
        let nc = UINavigationController(rootViewController: stockVC)
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        return true
    }
}

