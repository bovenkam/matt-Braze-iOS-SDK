//
//  AppDelegate.swift
//  Braze-iOS-SDK
//
//  Created by Martijn van de Bovenkamp on 5/9/22.
//  Copyright © 2022 Martijn van de Bovenkamp. All rights reserved.
//


import UserNotifications
import UIKit
import OneSignalFramework
import BrazeKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var braze: Braze? = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        // Remove this method to stop OneSignal Debugging
                OneSignal.Debug.setLogLevel(.LL_VERBOSE)
                
                // OneSignal initialization
                OneSignal.initialize("16033c4a-5bd5-4bc2-bacf-2eced529e351", withLaunchOptions: launchOptions)
                
                // requestPermission will show the native iOS notification permission prompt.
                // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
                OneSignal.Notifications.requestPermission({ accepted in
                  print("User accepted notifications: \(accepted)")
                }, fallbackToSettings: true)
                
                // Login your customer with externalId
                   OneSignal.login("testv3")
        
        
        
        
        //braze code
             let configuration = Braze.Configuration(
                 apiKey: "9159c96a-2321-47d6-841b-3e00a421d6a0",
                 endpoint: "sondheim.braze.com")
             // Enable logging of general SDK information (e.g. user changes, etc.)
             configuration.logger.level = .info
             
             //change user
             //AppDelegate.braze?.changeUser(userId: "mattdabreuv2726")
             
             //push code for braze
             let braze = Braze(configuration: configuration)
             AppDelegate.braze = braze
             
             return true
     
        return true
    }
    
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
      ) {
        AppDelegate.braze?.notifications.register(deviceToken: deviceToken)
      }


      func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
      ) {
        if let braze = AppDelegate.braze, braze.notifications.handleBackgroundNotification(
          userInfo: userInfo,
          fetchCompletionHandler: completionHandler
        ) {
          return
        }
        completionHandler(.noData)
      }
    }
