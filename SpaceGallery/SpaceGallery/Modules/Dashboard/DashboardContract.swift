//
//  DashboardContract.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import Foundation

protocol IDashboardView: IBaseView {
    // TODO: Declare view methods
}

protocol IDashboardPresenter: IBasePresenter {
    func getPhotos() -> [Photo]
    func photoItemPressed(with pressedItem: Photo)
}

protocol IDashboardInteractor: AnyObject {
    func retrievePhotos()
}

protocol IDashboardInteractorToPresenter: IBaseInteractorToPresenter {
    func photosReceived(_ photoList: [Photo])
}

protocol IDashboardRouter: AnyObject {
    // TODO: Declare wireframe methods
}
