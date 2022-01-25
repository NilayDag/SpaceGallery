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
    private var filteringOptions: [FilterOption] = FilterOption.allCases
}

extension DashboardPresenter: IDashboardPresenter {
    func viewDidLoad() {
        view?.showProgressHUD()
        view?.addFilteringButton()
        view?.setFilterOptions(to: filteringOptions)
        view?.setLayout(from: layoutGenerator)
        view?.hideProgressHUD()
    }

    func getPhotos() -> [Photo] {
        photos
    }

    func onFilterButtonPressed() {
        view?.openFilterOptionsPopover()
    }

    func filterPhotos(with option: FilterOption) {
        view?.hideFilterOptionsPopover()
        view?.showProgressHUD()
        interactor?.retrievePhotos(from: currentPage, with: option)
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
        view?.hideProgressHUD()
        // TODO: show empty state
    }

    func photosReceived(_ photoList: [Photo]) {
        photos = photoList
        view?.hideProgressHUD()
        view?.reloadCollectionView()
    }
}
