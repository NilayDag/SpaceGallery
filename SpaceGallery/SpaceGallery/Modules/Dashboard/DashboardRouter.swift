//
//  DashboardRouter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import UIKit

class DashboardRouter {

    // MARK: Properties
    weak var view: UIViewController?

    // MARK: Static methods
    static func setupModule() -> DashboardViewController {
        let viewController = UIStoryboard.loadViewController() as DashboardViewController
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
        let interactor = DashboardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DashboardRouter: IDashboardRouter {
    // TODO: Implement wireframe methods
}
