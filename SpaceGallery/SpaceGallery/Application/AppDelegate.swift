//
//  AppDelegate.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        #if !(RELEASE)
            AppRouter.shared.setMockConfig()
        #endif
        AppRouter.shared.start()
        return true
    }
}
