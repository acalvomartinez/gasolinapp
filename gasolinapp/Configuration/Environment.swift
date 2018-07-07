//
//  Environment.swift
//  gasolinapp
//
//  Created by antonio calvo on 07/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation

enum Environment: String {
  case debug
  case release

  var webURL: String {
    switch self {
    case .debug, .release:
      return "https://www.gasolinapp.com"
    }
  }

  var apiURL: String {
    switch self {
    case .debug, .release:
      return "https://api.gasolinapp.com"
    }
  }
}
