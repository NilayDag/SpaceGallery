//
//  DashboardContract.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import Foundation

protocol IDashboardView: IBaseView {
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator)
    func reloadCollectionView()
}

protocol IDashboardPresenter: IBasePresenter {
    func getPhotos() -> [Photo]
    func photoItemPressed(with pressedItem: Photo)
}

protocol IDashboardInteractor: AnyObject {
    func retrievePhotos(from pageNumber: Int)
}

protocol IDashboardInteractorToPresenter: IBaseInteractorToPresenter {
    func photosReceived(_ photoList: [Photo])
    func noPhotoFound()
}

protocol IDashboardRouter: AnyObject {
    // TODO: Declare wireframe methods
}
