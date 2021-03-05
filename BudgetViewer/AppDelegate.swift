//
//  AppDelegate.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }
}

