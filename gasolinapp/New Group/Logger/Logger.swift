//
//  Logger.swift
//  gasolinapp
//
//  Created by Toni on 08/11/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import Foundation

import SwiftyBeaver

final class Logger {
  
  static var logClass = SwiftyBeaver.self
  
  class func configure(for debug: Bool = false) {
    logClass.configure(for: debug)
  }
  
  class func verbose(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
    logClass.verbose(message, file, function, line: line, context: context)
  }
  
  class func debug(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
    logClass.debug(message, file, function, line: line, context: context)
  }
  
  class func info(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
    logClass.info(message, file, function, line: line, context: context)
  }
  
  class func warning(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
    logClass.warning(message, file, function, line: line, context: context)
  }
  
  class func error(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
    logClass.error(message, file, function, line: line, context: context)
  }
  
}
