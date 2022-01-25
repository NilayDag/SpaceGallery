//
//  DashboardInteractorMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation

@testable import SpaceGallery
class DashboardInteractorMock {
    // MARK: - Called Properties
    var retrievePhotosCalled = false

    // MARK: Properties
    weak var output: IDashboardInteractorToPresenter?
    var willDataRetrievedAsFail = false
    var photoListMockData = [Photo]()
}

extension DashboardInteractorMock: IDashboardInteractor {
    func retrievePhotos(from pageNumber: Int, with filterOption: FilterOption) {
        retrievePhotosCalled = true
        if willDataRetrievedAsFail {
            output?.wsErrorOccurred(with: Constants.Error.defaultErrorMessage)
        } else {
            if photoListMockData.isEmpty {
                output?.noPhotoFound()
            } else {
                output?.photosReceived(photoListMockData)
            }
        }
    }
}
