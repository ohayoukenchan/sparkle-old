//
//  AppDelegate.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/10/31.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import ReSwift
import ReSwiftRouter
import TwitterKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    #if DEVELOPMENT
    let firebasePlistName = "GoogleService-Info-development"
    #elseif STAGING
    let firebasePlistName = "GoogleService-Info-staging"
    #else
    let firebasePlistName = "GoogleService-Info"
    #endif
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        guard let filePath = Bundle.main.path(forResource: firebasePlistName, ofType: "plist") else {
            fatalError("GoogleService-Info.plist not found")
        }
        
        
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            fatalError("cannot initialize Firebase with given file")
        }
        
        FirebaseApp.configure(options: options)
    
        
        
        
        // Set a dummy view controller to satisfy UIKit
        window?.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        
        // Set Router
        router = Router(store: store, rootRoutable: rootRoutable) {
            $0.select {
                $0.navigationState
            }
        }
        
        // Twitter Config
        TWTRTwitter.sharedInstance().start(withConsumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        
        // Setup Keyboard Manager
        IQKeyboardManager.shared.enable = true
        
        // Start with splash screen (a.k.a Login screen)
        store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.splash]))
        
        window?.makeKeyAndVisible()
        
        
        return true
    }
    

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }

}

//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    }




