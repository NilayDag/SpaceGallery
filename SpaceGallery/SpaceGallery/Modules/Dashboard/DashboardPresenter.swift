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
    /**
     A lifecycle method triggered from view which is called after
     the view controller has loaded its view hierarchy into memory.
     Sets the initial setup functions implemented on view
    */
    func viewDidLoad() {
        view?.showEmptyState()
        view?.showProgressHUD()
        view?.addFilteringButton()
        view?.setFilterOptions(to: filteringOptions)
        view?.setLayout(from: layoutGenerator)
        view?.addPinchGestureToCollectionView()
        view?.hideProgressHUD()
    }

    /**
     Returns photo items.
    
     - Returns: A Photo Array that contains photo objects received from NASA API.
    */
    func getPhotos() -> [Photo] {
        photos
    }

    /**
     Triggers when filter button pressed on view. Tells view to open filter options popover.
    */
    func onFilterButtonPressed() {
        view?.openFilterOptionsPopover()
    }

    /**
     Filter photos with given FilterOption (Curiosity, Opportunity, or Spirit).
    
     - Parameters option: A filter option to apply filter to photos.
    */
    func filterPhotos(with option: FilterOption) {
        view?.hideFilterOptionsPopover()
        view?.hideEmptyState()
        view?.showProgressHUD()
        currentFilterOption = option
        photos.removeAll()
        currentPage = 1
        interactor?.retrievePhotos(from: currentPage, with: option)
    }

    /**
     Triggers when photo item pressed on collection view.
     Calls router in order to navigate to the photo details screen.
    
     - Parameters pressedItem: Pressed photo item.
    */
    func photoItemPressed(with pressedItem: Photo) {
        router?.navigateToPhotoDetails(for: pressedItem)
    }

    /**
     Triggers when colelction view's bottom scrolled. Loads more data if necessary.
    */
    func onLoadMore() {
        if !isPaginating, doesHavePhotoToFetch,
           let filterOption = currentFilterOption {
            interactor?.retrievePhotos(from: currentPage, with: filterOption)
            isPaginating = true
        }
    }

    /**
     Triggers when collection view pinched to zoom.
     Calculates transform and then calls the view to set freshly created transform scale.
    
     - Parameters sender: UIPinchGestureRecognizer object
     - Parameters collectionViewFrameWidth: A CGFloat that contains collection view's frame width
     - Parameters collectionViewBoundWidth: A CGFloat that contains collection view's bound width
    */
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
    /**
     Triggers when web service error occures from the network request.
    
     - Parameters message: A string that contains a message to show on the view.
    */
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
        isPaginating = false
    }

    /**
     Triggers when the photos recieved from asynchrounous get photos network request.
    
     - Parameters photoList: A photo array that contains filtered photo list.
    */
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
