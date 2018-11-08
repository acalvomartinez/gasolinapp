//
//  Loggable.swift
//  
//
//  Created by Toni on 08/11/2018.
//

import Foundation
import SwiftyBeaver

protocol Loggable {
  
  static func verbose(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
  static func debug(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
  static func info(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
  static func warning(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
  static func error(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
  
  static func configure(for debug: Bool)
}

extension SwiftyBeaver: Loggable {
  class func configure(for debug: Bool = false) {
    let format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $L $N.$F():$l $M"
    let level: SwiftyBeaver.Level = debug ? .verbose : .warning
    
    let console = setupConsole(format, minLevel: level)
    addDestination(console)
    
    let osConsole = OSLogDestination(minLevel: level)
    addDestination(osConsole)
    
    if !debug {
      let crashlyticsConsole = CrashlyticsDestination(format)
      addDestination(crashlyticsConsole)
    }
  }
}

extension SwiftyBeaver {
  
  private class func setupConsole(_ format: String, minLevel: SwiftyBeaver.Level) -> ConsoleDestination {
    let console = ConsoleDestination()
    console.format = format
    console.minLevel = minLevel
    console.levelString.verbose = "📢"
    console.levelString.debug = "🤓"
    console.levelString.info = "🦄"
    console.levelString.warning = "💩"
    console.levelString.error = "💀"
    
    return console
  }
}
