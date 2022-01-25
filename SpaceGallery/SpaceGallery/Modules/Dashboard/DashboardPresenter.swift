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
    private var currentPage: Int = 1
    private var isPaginating: Bool = false
    private var doesHavePhotoToFetch: Bool = true
    private var currentFilterOption: FilterOption?
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
        currentFilterOption = option
        photos.removeAll()
        currentPage = 1
        interactor?.retrievePhotos(from: currentPage, with: option)
    }

    func photoItemPressed(with pressedItem: Photo) {
        router?.navigateToPhotoDetails(for: pressedItem)
    }

    func onLoadMore() {
        if !isPaginating, doesHavePhotoToFetch,
           let filterOption = currentFilterOption {
            interactor?.retrievePhotos(from: currentPage, with: filterOption)
            isPaginating = true
        }
    }
}

extension DashboardPresenter: IDashboardInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
        isPaginating = false
    }

    func noPhotoFound() {
        view?.hideProgressHUD()
        isPaginating = false
        // TODO: show empty state
    }

    func photosReceived(_ photoList: [Photo]) {
        if photoList.isEmpty {
            doesHavePhotoToFetch = false
        } else {
            photos.append(contentsOf: photoList)
            isPaginating = false
            doesHavePhotoToFetch = true
            currentPage += 1
            view?.hideProgressHUD()
            view?.reloadCollectionView()
        }
    }
}
