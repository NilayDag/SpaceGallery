//
//  DashboardPresenterMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation
import XCTest

@testable import SpaceGallery
class DashboardPresenterMock {
    // MARK: - Properties
    var expectation: XCTestExpectation?

    // MARK: - Called Properties
    var getPhotosCalled = false
    var onFilterButtonPressedCalled = false
    var filterPhotosCalled = false
    var photoItemPressedCalled = false
    var onLoadMoreCalled = false

    private var currentPage: Int = 1
    private var isPaginating: Bool = false
    private var doesHavePhotoToFetch: Bool = true
    private var currentFilterOption: FilterOption?
    private var photos: [Photo] = [Photo]()
    private var filteringOptions: [FilterOption] = FilterOption.allCases
}

extension DashboardPresenterMock: IDashboardPresenter {
    func viewDidLoad() {}

    func getPhotos() -> [Photo] {
        getPhotosCalled = true
        return photos
    }

    func onFilterButtonPressed() {
        onFilterButtonPressedCalled = true
    }

    func filterPhotos(with option: FilterOption) {
        filterPhotosCalled = true
        currentFilterOption = option
        photos.removeAll()
        currentPage = 1
    }

    func photoItemPressed(with pressedItem: Photo) {
        photoItemPressedCalled = true
    }

    func onLoadMore() {
        onLoadMoreCalled = true
        if !isPaginating, doesHavePhotoToFetch,
           currentFilterOption != nil {
            isPaginating = true
        }
    }
}

extension DashboardPresenterMock: IDashboardInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        wsErrorOccurredCalled = true
        expectation?.fulfill()
    }

    func noPhotoFound() {
        noPhotoFoundCalled = true
        isPaginating = false
    }

    func photosReceived(_ photoList: [Photo]) {
        photosReceivedCalled = true
        if photoList.isEmpty {
            doesHavePhotoToFetch = false
        } else {
            photos.append(contentsOf: photoList)
            isPaginating = false
            doesHavePhotoToFetch = true
            currentPage += 1
        }
        expectation?.fulfill()
    }
}
