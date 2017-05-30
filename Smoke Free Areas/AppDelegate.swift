//
//  AppDelegate.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 19/04/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        UITabBar.appearance().tintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 10.0)], for: .normal)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
    }


}

