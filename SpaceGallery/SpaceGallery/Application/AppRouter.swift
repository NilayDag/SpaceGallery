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

    func setMockConfig() {
        var isMockEnabled: Bool = false
        var isUnitTesting: Bool = false
        #if MOCK_ENABLED
            isMockEnabled = true
        #endif

        #if DEBUG
        isUnitTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        #endif
        if isUnitTesting || isMockEnabled {
            NetworkMockManager.shared.loadRequiredStubs()
        }
    }

    func start() {
        let viewController = DashboardRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
