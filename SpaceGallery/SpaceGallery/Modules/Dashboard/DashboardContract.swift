//
//  DashboardContract.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import UIKit

protocol IDashboardView: IBaseView {
    func addFilteringButton()
    func setFilterOptions(to options: [FilterOption])
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator)
    func openFilterOptionsPopover()
    func hideFilterOptionsPopover()
    func reloadCollectionView()
    func collectionViewScrolled(with position: CGFloat)
}

protocol IDashboardPresenter: IBasePresenter {
    func getPhotos() -> [Photo]
    func onFilterButtonPressed()
    func filterPhotos(with options: FilterOption)
    func photoItemPressed(with pressedItem: Photo)
    func onLoadMore()
}

protocol IDashboardInteractor: AnyObject {
    func retrievePhotos(from pageNumber: Int, with filterOption: FilterOption)
}

protocol IDashboardInteractorToPresenter: IBaseInteractorToPresenter {
    func photosReceived(_ photoList: [Photo])
    func noPhotoFound()
}

protocol IDashboardRouter: AnyObject {
    func navigateToPhotoDetails(for photo: Photo)
}
