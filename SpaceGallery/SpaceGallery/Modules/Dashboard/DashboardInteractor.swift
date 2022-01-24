//
//  DashboardInteractor.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import Foundation

class DashboardInteractor {

    // MARK: Properties
    weak var output: IDashboardInteractorToPresenter?
    var apiClient: APIClient?
}

extension DashboardInteractor: IDashboardInteractor {
    func retrievePhotos(from pageNumber: Int) {
        apiClient?.retrievePhotos(page: pageNumber, onSuccess: { [weak self] response in
            guard let self = self else { return }
            if let photos = response.results?.photos {
                if photos.isEmpty {
                    self.output?.noPhotoFound()
                } else {
//                    self.output?.increaseCurrentPage()
                    self.output?.photosReceived(photos)
                }
            } else {
                self.output?.wsErrorOccurred(with: Constants.Error.defaultErrorMessage)
            }
        }, onError: { [weak self] (error) in
            guard let self = self else { return }
            self.output?.wsErrorOccurred(with: error?.message ?? Constants.Error.defaultErrorMessage)
        })
    }
}
