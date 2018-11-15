//
//  main.swift
//  Chicfy
//
//  Created by antonio calvo on 10/05/2018.
//  Copyright © 2018 Chicfy.com. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("gasolinappTests.TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
