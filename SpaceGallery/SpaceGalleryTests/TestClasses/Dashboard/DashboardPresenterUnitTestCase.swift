//
//  DashboardPresenterUnitTestCase.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import XCTest

@testable import SpaceGallery
class DashboardPresenterUnitTestCase: XCTestCase {
    var sut: IDashboardPresenter & IDashboardInteractorToPresenter = DashboardPresenter()
    var view = DashboardViewMock()
    var interactor = DashboardInteractorMock()
    var router = DashboardRouterMock()

    func makeAndResetSUT() {
        let presenter = DashboardPresenter()
        view = DashboardViewMock()
        interactor = DashboardInteractorMock()
        router = DashboardRouterMock()

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        interactor.output = presenter
        sut = presenter
    }

    override func setUp() {
        makeAndResetSUT()
    }

    override func tearDown() {
        makeAndResetSUT()
    }

    func testViewDidLoad() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(view.showEmptyStateCalled,
                      "showEmptyState function on view should be called")
        XCTAssertTrue(view.addFilteringButtonCalled,
                      "addFilteringButton function on view should be called")
        XCTAssertTrue(view.setFilterOptionsCalled,
                      "setFilterOptions function on view should be called")
        XCTAssertTrue(view.setLayoutCalled,
                      "setLayout function on view should be called")
    }

    func testGetPhotos() {
        // Given
        interactor.photoListMockData = createPhotoListMockData()

        // When
        sut.photosReceived(interactor.photoListMockData)

        // Then
        XCTAssertEqual(sut.getPhotos().count, interactor.photoListMockData.count,
                       "Photo item count inside Presenter, should be equal to created photo mock data.")
    }

    func testOnFilterButtonPressed() {
        // When
        sut.onFilterButtonPressed()

        // Then
        XCTAssertTrue(view.openFilterOptionsPopoverCalled,
                      "openFilterOptionsPopover function on view should be called")
    }

    func testFilterPhotos() {
        // Given
        let filterOptionMockData = createFilterOptionMockData()
        
        // When
        sut.filterPhotos(with: filterOptionMockData)

        // Then
        XCTAssertTrue(view.hideFilterOptionsPopoverCalled,
                      "hideFilterOptionsPopover function on view should be called")
        XCTAssertTrue(view.hideEmptyStateCalled,
                      "hideEmptyState function on view should be called")
        XCTAssertEqual(sut.getPhotos().count, 0,
                      "Photo items on presenter should be cleared.")
        XCTAssertTrue(interactor.retrievePhotosCalled,
                      "retrievePhotos function on interactor should be called.")
    }

    func testPhotoItemPressed() {
        // Given
        let pressedItem = createPhotoMockItem()
        
        // When
        sut.photoItemPressed(with: pressedItem)

        // Then
        XCTAssertTrue(router.navigateToPhotoDetailsCalled,
                      "navigateToPhotoDetails function on router should be called")
    }
    
    func testOnLoadMore_WithFilterOption() {
        // Given
        let filterOptionMockData = createFilterOptionMockData()
        sut.filterPhotos(with: filterOptionMockData)
        
        // When
        sut.onLoadMore()

        // Then
        XCTAssertTrue(interactor.retrievePhotosCalled,
                      "retrievePhotos function on interactor should be called")
    }
    
    func testOnLoadMore_WithoutFilterOption() {
        // When
        sut.onLoadMore()

        // Then
        XCTAssertFalse(interactor.retrievePhotosCalled,
                      "retrievePhotos function on interactor shouldn't be called without a filter option")
    }

    func testWSErrorOccured() {
        // Given
        let errorMessage = Constants.Error.defaultErrorMessage
    
        // When
        sut.wsErrorOccurred(with: errorMessage)

        // Then
        XCTAssertFalse(view.isProgressShowing,
                       "When wsErrorOccured function called on Presenter, view should hide progress hud.")
        XCTAssertTrue(view.showErrorDialogCalled,
                       "When wsErrorOccured function called on Presenter, view should show error message")
    }
    
    func testPhotosReceived() {
        // Given
        let photosMockData = createPhotoListMockData()
        interactor.photoListMockData = photosMockData
    
        // When
        sut.photosReceived(photosMockData)

        // Then
        XCTAssertGreaterThan(sut.getPhotos().count, 0,
                       "When photosReceived function called on Presenter, photo item count on presenter should be greater than 0.")
        XCTAssertFalse(view.isProgressShowing,
                       "When photosReceived function called on Presenter, view should hide progress hud.")
        XCTAssertTrue(view.reloadCollectionViewCalled,
                       "When photosReceived function called on Presenter, view should reload collection view.")
        XCTAssertFalse(view.showErrorDialogCalled,
                       "When photosReceived function called on Presenter, view shouldn't show any error messages.")
    }

    func testPhotosReceived_WithEmptyPhotoList() {
        // Given
        let photosMockData = [Photo]()
    
        // When
        sut.photosReceived(photosMockData)

        // Then
        XCTAssertEqual(sut.getPhotos().count, 0,
                       "When getPhotos function called with an empty list on Presenter, photo item count on presenter should be equal to 0.")
        XCTAssertFalse(view.isProgressShowing,
                       "When getPhotos function called with an empty list on Presenter, view should hide progress hud.")
        XCTAssertFalse(view.reloadCollectionViewCalled,
                       "When getPhotos function called with an empty list on Presenter, view should reload collection view.")
    }
    
    private func createFilterOptionMockData() -> FilterOption {
        .curiosity
    }

    private func createPhotoListMockData() -> [Photo] {
        var array = [Photo]()
        array.append(createPhotoMockItem())
        array.append(createPhotoMockItem())
        array.append(createPhotoMockItem())
        array.append(createPhotoMockItem())
        array.append(createPhotoMockItem())
        array.append(createPhotoMockItem())
        return array
    }

    private func createPhotoMockItem() -> Photo {
        Photo(id: 102693,
              sol: 1000,
              camera: createCameraMockData(),
              imgSrc: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
              earthDate: "2015-05-30",
              rover: createRoverMockData())
    }
    
    private func createCameraMockData() -> Camera {
        Camera(id: 20,
               roverID: 5,
               name: "MOCK Camera Name",
               fullName: "MOCK Camera Full Name")
    }
    
    private func createRoverMockData() -> Rover {
        Rover(id: 5,
              name: "Curiosity",
              status: "Mock Status",
              landingDate: "2012-08-06",
              launchDate: "2011-11-26")
    }
}
