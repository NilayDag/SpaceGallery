//
//  DashboardRouterMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import UIKit

@testable import SpaceGallery
class DashboardRouterMock {
    // MARK: - Properties
    weak var view: UIViewController?
    var navigateToPhotoDetailsCalled = false
}

extension DashboardRouterMock: IDashboardRouter {
    func navigateToPhotoDetails(for photo: Photo) {
        navigateToPhotoDetailsCalled = true
    }
}
