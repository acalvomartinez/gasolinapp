//
//  AppDelegateComponent.swift
//  gasolinapp
//
//  Created by antonio calvo on 01/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import UIKit

protocol AppDelegateComponent {
  var openURLScheme: String { get }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool
  func applicationDidBecomeActive(_ application: UIApplication)
}

extension AppDelegateComponent {
  var openURLScheme: String {
    return ""
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  }

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
  }

  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
    return false
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }
}

