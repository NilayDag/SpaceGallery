//
//  AppRouter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import UIKit

final class AppRouter {

    static var shared = AppRouter()

    var window: UIWindow? {
        UIApplication.shared.delegate?.window ?? UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        let viewController = DashboardRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
