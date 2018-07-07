//
//  AppDelegateTests.swift
//  gasolinappTests
//
//  Created by antonio calvo on 01/07/2018.
//  Copyright © 2018 acalvomartinez. All rights reserved.
//

import XCTest
@testable import gasolinapp

class AppDelegateTests: XCTestCase {

  var sut: AppDelegate!

  override func setUp() {
    super.setUp()

    createSut()
  }

  func createSut() {
    sut = AppDelegate()
  }

  override func tearDown() {
    destroySut()

    super.tearDown()
  }

  func destroySut() {
    sut = nil
  }

  // MARK: - Tests

  func testSutIsntNil() {
    XCTAssertNotNil(sut, "SUT must not be nil.")
  }

  func testDidFinishLaunchingWithOptionsReturnsTrueIfAllTasksReturnTrue() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.components = [componentMocked1, componentMocked2]

    let didFinished = altSut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

    XCTAssertTrue(didFinished)
  }

  func testDidFinishLaunchingWithOptionsReturnsFalseIfAnyTaskReturnsFalse() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: false)
    let componentMocked3 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2, componentMocked3]

    let didFinished = altSut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

    XCTAssertFalse(didFinished)
  }

  func testDidReceiveRemoteNotificationIsInvoked() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2]

    altSut.application(UIApplication.shared, didReceiveRemoteNotification: ["":""])

    XCTAssertTrue(componentMocked1.didReceiveRemoteNotificationInvoked)
    XCTAssertTrue(componentMocked2.didReceiveRemoteNotificationInvoked)
  }

  func testDidRegisterForRemoteNotificationsWithDeviceTokenIsInvoked() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2]

    altSut.application(UIApplication.shared, didRegisterForRemoteNotificationsWithDeviceToken: Data())

    XCTAssertTrue(componentMocked1.didRegisterForRemoteNotificationsInvoked)
    XCTAssertTrue(componentMocked2.didRegisterForRemoteNotificationsInvoked)
  }

  func testContinueUserActivityReturnsTrueIfAllTasksReturnTrue() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2]

    let userActivity = NSUserActivity(activityType: "com.myCompany.myEditor.editing")
    let result = altSut.application(UIApplication.shared, continue: userActivity, restorationHandler: { _ in })

    XCTAssertTrue(result)
  }

  func testContinueUserActivityReturnsFalseIfAnyTaskReturnsFalse() {
    let componentMocked1 = ComponentMocked(result: true)
    let componentMocked2 = ComponentMocked(result: false)
    let componentMocked3 = ComponentMocked(result: true)

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2, componentMocked3]

    let userActivity = NSUserActivity(activityType: "com.myCompany.myEditor.editing")
    let result = altSut.application(UIApplication.shared, continue: userActivity, restorationHandler: { _ in })

    XCTAssertFalse(result)
  }

  func testOpenURLReturnsFalseIfAllTasksReturnFalse() {
    let componentMocked1 = ComponentMocked(result: false, scheme: "facebook")
    let componentMocked2 = ComponentMocked(result: false, scheme: "google")

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2]

    guard let url = URL(string: "http://gasolinapp.com") else {
      XCTFail("Creating URL")
      return
    }

    let options = [UIApplicationOpenURLOptionsKey("test"): "test"]
    let result = altSut.application(UIApplication.shared, open: url, options: options)

    XCTAssertFalse(result)
  }

  func testOpenURLReturnsFalseIfAnyTaskReturnsFalse() {
    let componentMocked1 = ComponentMocked(result: true, scheme: "http")
    let componentMocked2 = ComponentMocked(result: false, scheme: "facebook")

    let altSut = AppDelegateMock()
    altSut.componentsMocked = [componentMocked1, componentMocked2]

    guard let url = URL(string: "http://gasolinapp.com") else {
      XCTFail("Creating URL")
      return
    }

    let options = [UIApplicationOpenURLOptionsKey("test"): "test"]
    let result = altSut.application(UIApplication.shared, open: url, options: options)

    XCTAssertTrue(result)
  }

  // MARK: - Mocks & Stubs

  class AppDelegateMock: AppDelegate {

    var componentsMocked: [AppDelegateComponent] = []

    override var components: [AppDelegateComponent] {
      set {
        componentsMocked = newValue
      }
      get {
        return componentsMocked
      }
    }
  }

  class ComponentMocked: AppDelegateComponent {

    var didRegisterForRemoteNotificationsInvoked = false
    var didReceiveRemoteNotificationInvoked = false

    var openURLScheme: String {
      return scheme
    }

    private let result: Bool
    private let scheme: String

    init(result: Bool, scheme: String = "") {
      self.result = result
      self.scheme = scheme
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      return result
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      didRegisterForRemoteNotificationsInvoked = true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      didReceiveRemoteNotificationInvoked = true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
      return result
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
      return result
    }
  }
}

