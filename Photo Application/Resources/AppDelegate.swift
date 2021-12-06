//
//  AppDelegate.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = MainTabBarController()
            
            return true
    }
}


//F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY

//J0s-ScBgmK8nGW77vjGxL1ETMGJyVWC3FmQcXdd3X1w
