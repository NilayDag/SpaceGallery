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
    func addFilteringButton()
    func setFilterOptions(to options: [FilterOption])
    func openFilterOptionsPopover()
    func hideFilterOptionsPopover()
    func reloadCollectionView()
}

protocol IDashboardPresenter: IBasePresenter {
    func getPhotos() -> [Photo]
    func onFilterButtonPressed()
    func filterPhotos(with options: FilterOption)
    func photoItemPressed(with pressedItem: Photo)
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
