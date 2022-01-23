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
    func retrievePhotos() {
        // TODO: will be implemented
    }
}
