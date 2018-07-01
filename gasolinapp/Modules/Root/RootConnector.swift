//
//  RootConnector.swift
//  gasolinapp
//
//  Created by antonio calvo on 01/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import UIKit

final class RootConnector {
  var view: ViewController!

  func wireUp(in window: UIWindow,
              viewController: ViewController = RootConnector.initialViewController()) {
    view = viewController
    window.rootViewController = view
  }
}

extension RootConnector {
  static func initialViewController() -> ViewController {
    return StoryboardScene.Main.viewController.instantiate()
  }
}
