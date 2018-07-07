//
//  AppConfiguration.swift
//  gasolinapp
//
//  Created by antonio calvo on 07/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation

protocol BundleProtocol {
  var infoDictionary: [String: Any]? { get }
  func object(forInfoDictionaryKey key: String) -> Any?
}

extension Bundle: BundleProtocol { }

final class AppConfiguration {
  private let bundle: BundleProtocol

  init(bundle: BundleProtocol = Bundle.main) {
    self.bundle = bundle
  }

  lazy var environment: Environment = {
    guard let configuration = bundle.object(forInfoDictionaryKey: "Application Configuration") as? String else {
      return .debug
    }

    guard let environment = Environment(rawValue: configuration) else {
      return .debug
    }

    return environment
  }()

  var isDebug: Bool {
    return environment == .debug
  }

  var apiURL: String {
    return environment.apiURL
  }

  var webURL: String {
    return environment.webURL
  }
}
