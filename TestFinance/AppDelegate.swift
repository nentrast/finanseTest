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

    var appFlowController: AppFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appFlowStart()
        return true
    }
    
    private func appFlowStart() {
        let nc = UINavigationController()
        appFlowController = AppFlowController.init(nc: nc)
        appFlowController?.start()
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}

