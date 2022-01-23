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
    func viewDidLoad() {
        // TODO: will be implemented
    }

    func getPhotos() -> [Photo] {
        // TODO: will be implemented
        []
    }

    func photoItemPressed(with pressedItem: Photo) {
        // TODO: will be implemented
    }
}

extension DashboardPresenter: IDashboardInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        // TODO: will be implemented
    }

    func photosReceived(_ photoList: [Photo]) {
        // TODO: will be implemented
    }
}
