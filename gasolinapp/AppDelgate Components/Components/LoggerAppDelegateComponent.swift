//
//  LoggerAppDelegateComponent.swift
//  gasolinapp
//
//  Created by Toni on 12/11/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import UIKit

final class LoggerAppDelegateComponent: AppDelegateComponent {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    Logger.configure(for: AppConfiguration().isDebug)
    return true
  }
}
