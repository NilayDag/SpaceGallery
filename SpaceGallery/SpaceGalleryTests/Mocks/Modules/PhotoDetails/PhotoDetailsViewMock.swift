//
//  PhotoDetailsViewMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation

@testable import SpaceGallery
public class PhotoDetailsViewMock: IPhotoDetailsView {
    // MARK: - Properties
    var isProgressShowing = false

    // MARK: - Called Properties
    var showErrorDialogCalled = false
    var setUIElementsCalled = false

    public func showProgressHUD() {
        isProgressShowing = true
    }

    public func hideProgressHUD() {
        isProgressShowing = false
    }
    
    public func showErrorDialog(with message: String) {
        showErrorDialogCalled = true
    }

    public func setUIElements(with photoItem: Photo) {
        setUIElementsCalled = true
    }
}
