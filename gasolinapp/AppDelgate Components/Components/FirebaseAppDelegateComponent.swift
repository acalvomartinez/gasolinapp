//
//  FirebaseAppDelegateComponent.swift
//  gasolinapp
//
//  Created by antonio calvo on 07/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseAppDelegateComponent: AppDelegateComponent {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
