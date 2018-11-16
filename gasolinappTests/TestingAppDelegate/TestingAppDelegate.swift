//
//  TestingAppDelegate.swift
//  Chicfy
//
//  Created by antonio calvo on 10/05/2018.
//  Copyright © 2018 Chicfy.com. All rights reserved.
//

import UIKit
@testable import gasolinapp

class TestingAppDelegate: UIResponder {

  var window: UIWindow?
  let components = TestingAppDelegateComponents.allComponents

  func configureInitialViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
  }
  
  lazy var rootViewController: UIViewController = {
    let vc = TestingViewController(nibName: "TestingViewController", bundle: Bundle(for: TestingAppDelegate.self))
    return vc
  }()
}

extension TestingAppDelegate: UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
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

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    components.forEach {
      $0.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
  }

  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    let delegateResult = components.reduce(true) { (result, task) -> Bool in
      if (result == false) {
        return result
      }

      return task.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    return delegateResult
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
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
