//
//  DashboardPresenter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import Foundation

class DashboardPresenter {

    // MARK: Properties
    weak var view: IDashboardView?
    var router: IDashboardRouter?
    var interactor: IDashboardInteractor?
}

extension DashboardPresenter: IDashboardPresenter {
    // TODO: implement presentation methods
}

extension DashboardPresenter: IDashboardInteractorToPresenter {
    // TODO: implement interactor output methods
}
