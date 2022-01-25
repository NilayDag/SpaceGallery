//
//  PhotoDetailsPresenterMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation

@testable import SpaceGallery
class PhotoDetailsPresenterMock {
    // MARK: - Called Properties
    var setPhotoItemCalled = false

    // MARK: - Properties
    private var photoItem: Photo?
}

extension PhotoDetailsPresenterMock: IPhotoDetailsPresenter {

    func viewDidLoad() {}

    func setPhotoItem(to item: Photo) {
        setPhotoItemCalled = true
        photoItem = item
    }
}
