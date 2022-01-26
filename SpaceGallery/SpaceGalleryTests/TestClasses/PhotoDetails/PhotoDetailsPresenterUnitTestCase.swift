//
//  PhotoDetailsUnitTestCase.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import XCTest

@testable import SpaceGallery
class PhotoDetailsPresenterUnitTestCase: XCTestCase {
    var sut: IPhotoDetailsPresenter = PhotoDetailsPresenter()
    var view = PhotoDetailsViewMock()

    func makeAndResetSUT() {
        let presenter = PhotoDetailsPresenter()
        view = PhotoDetailsViewMock()

        presenter.view = view

        sut = presenter
    }

    override func setUp() {
        makeAndResetSUT()
    }

    override func tearDown() {
        makeAndResetSUT()
    }

    func testViewDidLoad_WithPhotoDetailsItem() {
        // Given
        let photoDetailItemMockItem = createPhotoDetailsMockItem()

        // When
        sut.setPhotoItem(to: photoDetailItemMockItem)
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(view.setUIElementsCalled,
                      "setUIElements function on view should be called")
    }

    func testViewDidLoad_WithoutPhotoDetailsItem() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertFalse(view.setUIElementsCalled,
                      "setUIElements function on view shouldn't be called")
    }

    private func createPhotoDetailsMockItem() -> Photo {
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
