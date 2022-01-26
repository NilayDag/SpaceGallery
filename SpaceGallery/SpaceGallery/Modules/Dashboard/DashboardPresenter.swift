//
//  DashboardPresenter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import UIKit

class DashboardPresenter {

    // MARK: Properties
    weak var view: IDashboardView?
    var router: IDashboardRouter?
    var interactor: IDashboardInteractor?
    private var layoutGenerator = GalleryCollectionViewLayoutGenerator()
    private var isEmptyStateShowing: Bool = false
    private var currentPage: Int = 1
    private var isPaginating: Bool = false
    private var doesHavePhotoToFetch: Bool = true
    private var currentFilterOption: FilterOption?
    private var photos: [Photo] = [Photo]()
    private var filteringOptions: [FilterOption] = FilterOption.allCases
}

extension DashboardPresenter: IDashboardPresenter {
    func viewDidLoad() {
        view?.showEmptyState()
        view?.showProgressHUD()
        view?.addFilteringButton()
        view?.setFilterOptions(to: filteringOptions)
        view?.setLayout(from: layoutGenerator)
        view?.addPinchGestureToCollectionView()
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
        view?.hideEmptyState()
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

    func onCollectionViewPinched(sender: UIPinchGestureRecognizer,
                                 with collectionViewFrameWidth: CGFloat,
                                 _ collectionViewBoundWidth: CGFloat) {
        let currentScale = collectionViewFrameWidth / collectionViewBoundWidth
        let newScale = currentScale * sender.scale
        let transform = CGAffineTransform(scaleX: newScale, y: newScale)
        view?.setCollectionViewTransform(to: newScale > 1 ? transform: .identity)
        sender.scale = 1
    }
}

extension DashboardPresenter: IDashboardInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
        isPaginating = false
    }

    func photosReceived(_ photoList: [Photo]) {
        view?.hideProgressHUD()
        if photoList.isEmpty {
            doesHavePhotoToFetch = false
            if photos.isEmpty, !isEmptyStateShowing {
                self.view?.showEmptyState()
            }
        } else {
            photos.append(contentsOf: photoList)
            isPaginating = false
            doesHavePhotoToFetch = true
            currentPage += 1
            view?.reloadCollectionView()
            if !isEmptyStateShowing {
                view?.hideEmptyState()
            }
        }
    }
}
