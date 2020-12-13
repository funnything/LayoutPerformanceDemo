//
//  AppDelegate.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/11.
//

import Then
import UIKit

enum Consts {
    static let yearFrom = 2011
    static let yearTo = 2020
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.rootViewController = UINavigationController(rootViewController: ViewController())
            $0.backgroundColor = .systemBackground
            $0.makeKeyAndVisible()
        }

        return true
    }
}
