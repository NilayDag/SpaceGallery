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
    private var layoutGenerator = GalleryCollectionViewLayoutGenerator()
    private var currentPage: Int = 0
    private var photos: [Photo] = [Photo]()
}

extension DashboardPresenter: IDashboardPresenter {
    func viewDidLoad() {
        view?.showProgressHUD()
        view?.setLayout(from: layoutGenerator)
        interactor?.retrievePhotos(from: currentPage)
    }

    func getPhotos() -> [Photo] {
        photos
    }

    func photoItemPressed(with pressedItem: Photo) {
        router?.navigateToPhotoDetails(for: pressedItem)
    }
}

extension DashboardPresenter: IDashboardInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
    }

    func noPhotoFound() {
        // TODO: show empty state
        view?.hideProgressHUD()
    }

    func photosReceived(_ photoList: [Photo]) {
        photos = photoList
        view?.hideProgressHUD()
        view?.reloadCollectionView()
    }
}
