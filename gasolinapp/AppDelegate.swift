//
//  AppDelegate.swift
//  gasolinapp
//
//  Created by antonio calvo on 01/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegateSwift: UIResponder {
  var window: UIWindow?
  var rootConnector = RootConnector()
  var components = AppDelegateComponents.allComponents

  func configureInitialViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    if let window = window {
      rootConnector.wireUp(in: window)
    }
    window?.makeKeyAndVisible()
  }
}

extension AppDelegateSwift: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    let delegateResult = components.reduce(true) { (result, task) -> Bool in
      if (result == false) {
        return result
      }

      return task.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    configureInitialViewController()

    return delegateResult
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    components.forEach {
      $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
  }

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    components.forEach {
      $0.application(application, didReceiveRemoteNotification: userInfo)
    }
  }

  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    let delegateResult = components.reduce(true) { (result, task) -> Bool in
      if (result == false) {
        return result
      }

      return task.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    return delegateResult
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    guard let scheme = url.scheme else {
      return false
    }

    let component = components.filter { $0.openURLScheme == scheme }.first

    guard let componentWithURL = component else {
      return false
    }

    return componentWithURL.application(app, open: url, options: options)
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    components.forEach {
      $0.applicationDidBecomeActive(application)
    }
  }

}


