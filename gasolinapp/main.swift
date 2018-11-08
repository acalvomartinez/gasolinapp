//
//  main.swift
//  Chicfy
//
//  Created by antonio calvo on 10/05/2018.
//  Copyright © 2018 Chicfy.com. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass?
if (NSClassFromString("gasolinappTests.TestingAppDelegate") != nil) {
  appDelegateClass = NSClassFromString("gasolinappTests.TestingAppDelegate")
} else {
  appDelegateClass = AppDelegate.self
}
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass!))
