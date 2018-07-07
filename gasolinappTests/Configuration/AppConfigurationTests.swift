//
//  AppConfigurationTests.swift
//  gasolinappTests
//
//  Created by antonio calvo on 07/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import XCTest
@testable import gasolinapp

class AppConfigurationTests: XCTestCase {
  var sut: AppConfiguration!

  override func setUp() {
    super.setUp()

    createSut()
  }

  func createSut() {
    sut = AppConfiguration(bundle: TestDebugBundle())
  }

  override func tearDown() {
    destroySut()

    super.tearDown()
  }

  func destroySut() {
    sut = nil
  }

  // MARK: - Tests

  func testEnvironmentShouldMatchWithBundleEnviroment() {
    XCTAssertEqual(sut.environment, .debug)
  }

  func testWebURLShouldMatchWithEnviromentWebURL() {
    XCTAssertEqual(sut.environment.webURL, "https://www.gasolinapp.com")
  }
  func testAPIURLShouldMatchWithEnviromentWebURL() {
    XCTAssertEqual(sut.environment.apiURL, "https://api.gasolinapp.com")
  }
}

struct TestDebugBundle: BundleProtocol {
  var infoDictionary: [String : Any]? {
    return ["Application Configuration": "debug"]
  }

  func object(forInfoDictionaryKey key: String) -> Any? {
    return infoDictionary?[key]
  }
}
