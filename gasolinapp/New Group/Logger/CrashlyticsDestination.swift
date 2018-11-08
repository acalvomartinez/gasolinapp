//
//  CrashlyticsDestination.swift
//  gasolinapp
//
//  Created by Toni on 08/11/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation

import SwiftyBeaver
import Crashlytics

final class CrashlyticsDestination: BaseDestination {
  
  public init(_ format: String) {
    super.init()
    
    self.format = format
    self.minLevel = .warning
    self.levelString.warning = "WARNING"
    self.levelString.error = "ERROR"
  }
  
  override public func send(_ level: SwiftyBeaver.Level, msg: String, thread: String, file: String, function: String, line: Int, context: Any?) -> String? {
    let formattedMessage = super.send(level, msg: msg, thread: thread, file: file, function: function, line: line, context: context)
    
    if let msg = formattedMessage {
      if level.rawValue >= minLevel.rawValue {
        CLSLogv("%@", getVaList([msg]))
      }
    }
    
    return formattedMessage
  }
}

