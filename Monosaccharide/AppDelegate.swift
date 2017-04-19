//
//  AppDelegate.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
            
            window?.rootViewController = DTGuideViewController()
            
        }
        customAppearance()
        return true
    }

    /// 显示主界面
    func showMainStoryboard()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateInitialViewController()
        window?.rootViewController = vc

    }

    /// 全局样式
    fileprivate func customAppearance()
    {
        // Tabbar
        UITabBar.appearance().tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        UITabBar.appearance().isTranslucent = false
       

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

//        loadReveal()
    }

    // MARK: - Reveal

    func loadReveal() {

        if NSClassFromString("IBARevealLoader") == nil {

            let revealLibName = "libReveal" // or "libReveal-tvOS" for tvOS targets

            let revealLibExtension = "dylib"

            var error: String?

            if let dylibPath = Bundle.main.path(forResource: revealLibName, ofType: revealLibExtension) {

//                print("Loading dynamic library \(dylibPath)")

                let revealLib = dlopen(dylibPath, RTLD_NOW)

                if revealLib == nil {

//                    error = String(UTF8String: dlerror())

                }

            } else {

                error = "File not found."

            }

            if error != nil {

                let alert = UIAlertController(title: "Reveal library could not be loaded",
                                              
                                              message: "\(revealLibName).\(revealLibExtension) failed to load with error: \(error!)",
                    
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

