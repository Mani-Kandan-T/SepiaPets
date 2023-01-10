//
//  AppDelegate.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    configureInitialViewController()
    return true
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    configureInitialViewController()
  }
  
  private func configureInitialViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var inititialViewController: UIViewController
    window = UIWindow()

    if !DateHelper.shared.isWorkingHours() {
      inititialViewController = storyboard.instantiateViewController(withIdentifier: Constants.noContentAccessViewController)
    } else {
      inititialViewController = storyboard.instantiateViewController(withIdentifier: Constants.initialNavigationController)
    }
    window?.rootViewController = inititialViewController
    window?.makeKeyAndVisible()
  }
}

