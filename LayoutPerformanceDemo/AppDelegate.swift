//
//  AppDelegate.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/11.
//

import Then
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.rootViewController = ViewController()
            $0.backgroundColor = .white
            $0.makeKeyAndVisible()
        }

        return true
    }
}
