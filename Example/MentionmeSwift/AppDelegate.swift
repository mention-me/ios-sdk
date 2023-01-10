//
//  AppDelegate.swift
//  MentionmeSwift
//
//  Created by andreasbagias on 03/06/2019.
//  Copyright (c) 2019 Mention-me. All rights reserved.
//

import MentionmeSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let config = MentionmeConfig(demo: true)
    config.debugNetwork = true
    Mentionme.shared.config = config
    let params = MentionmeRequestParameters(partnerCode: "PARTNER_CODE")
    if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
      params.appName = appName
    }
    if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
      params.appVersion = version
    }
    params.deviceType = "iphone"
    params.localeCode = "en_GB"
    Mentionme.shared.requestParameters = params
    Mentionme.shared.validationWarning = CustomValidationWarning()

    //this disables the debug printing of unsatisfied constraints
    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

}
