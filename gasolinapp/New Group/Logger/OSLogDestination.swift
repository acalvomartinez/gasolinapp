//
//  OSLogDestination.swift
//  gasolinapp
//
//  Created by Toni on 08/11/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation
import SwiftyBeaver
import os

final class OSLogDestination: BaseDestination {
  init(minLevel: SwiftyBeaver.Level) {
    super.init()
    self.minLevel = minLevel
  }
  
  override func send(_ level: SwiftyBeaver.Level,
                     msg: String,
                     thread: String,
                     file: String,
                     function: String,
                     line: Int,
                     context: Any?) -> String? {
    
    if level.rawValue >= minLevel.rawValue {
      
      let log = self.createOSLog(context: context)
      
      os_log("%@.%@:%i - \n%@",
             log: log,
             type: self.osLogLevelRelated(to: level),
             file, function, line, msg)
    }
    
    return super.send(level,
                      msg: msg,
                      thread: thread,
                      file: file,
                      function: function,
                      line: line)
  }
  
}

private extension OSLogDestination {
  
  func createOSLog(context: Any?) -> OSLog {
    let currentContext = context as? String ?? "Default"

    let subsystem = Bundle.main.bundleIdentifier ?? "com.logger.default"
    let customLog = OSLog(subsystem: subsystem, category: currentContext)
    return customLog
  }
  
  func osLogLevelRelated(to swiftyBeaverLogLevel: SwiftyBeaver.Level) -> OSLogType {
    var logType: OSLogType
    switch swiftyBeaverLogLevel {
    case .debug:
      logType = .debug
    case .verbose:
      logType = .default
    case .info:
      logType = .info
    case .warning:
      logType = .error
    case .error:
      logType = .fault
    }
    
    return logType
  }
}
