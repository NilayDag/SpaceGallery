//
//  DashboardInteractorUnitTestCase.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import XCTest

@testable import SpaceGallery
class DashboardInteractorUnitTestCase: XCTestCase {
    var presenter = DashboardPresenterMock()
    var sut: IDashboardInteractor = DashboardInteractor()
    var apiClient: APIClientInterface = APIClient()
    let mockPage: Int = 1

     func makeAndResetSUT() {
        let interactor = DashboardInteractor()
        presenter = DashboardPresenterMock()
        apiClient = APIClient()

        interactor.output = presenter
        interactor.apiClient = apiClient

        NetworkMockManager.shared.resetAllStubs()

        sut = interactor
     }

     override func setUp() {
         makeAndResetSUT()
     }

     override func tearDown() {
         makeAndResetSUT()
     }

    func testRetrievePhotos_WithCuriosityType_Success() {
        // Given
        let expectation = XCTestExpectation(description: "testRetrievePhotosWithCuriosityType as success")
        presenter.expectation = expectation

        // When
        sut.retrievePhotos(from: mockPage, with: .curiosity)

        // Then
        waitForExpectations(expectation: expectation)
        XCTAssertTrue(presenter.photosReceivedCalled,
                      "photosReceivedCalled function should be called")
        XCTAssertGreaterThan(presenter.getPhotos().count, 0,
                             "Photo items should be retrieved from interactor")
        XCTAssertEqual(presenter.getPhotos().first?.rover.name, FilterOption.curiosity.title,
                      "Retrieved rover names should be equal to curiosity.")
        XCTAssertFalse(presenter.wsErrorOccurredCalled,
                       "Error occured function shouldn't be called")
    }

    func testRetrievePhotos_WithOpportunityType_Success() {
        // Given
        let expectation = XCTestExpectation(description: "testRetrievePhotosWithOpportunityType as success")
        presenter.expectation = expectation

        // When
        sut.retrievePhotos(from: mockPage, with: .opportunity)

        // Then
        waitForExpectations(expectation: expectation)
        XCTAssertTrue(presenter.photosReceivedCalled,
                      "photosReceivedCalled function should be called")
        XCTAssertGreaterThan(presenter.getPhotos().count, 0,
                             "Photo items should be retrieved from interactor")
        XCTAssertEqual(presenter.getPhotos().first?.rover.name, FilterOption.opportunity.title,
                      "Retrieved rover names should be equal to opportunity.")
        XCTAssertFalse(presenter.wsErrorOccurredCalled,
                       "Error occured function shouldn't be called")
    }
    
    func testRetrievePhotos_WithSpiritType_Success() {
        // Given
        let expectation = XCTestExpectation(description: "testRetrievePhotosWithSpiritType as success")
        presenter.expectation = expectation

        // When
        sut.retrievePhotos(from: mockPage, with: .spirit)

        // Then
        waitForExpectations(expectation: expectation)
        XCTAssertTrue(presenter.photosReceivedCalled,
                      "photosReceivedCalled function should be called")
        XCTAssertGreaterThan(presenter.getPhotos().count, 0,
                             "Photo items should be retrieved from interactor")
        XCTAssertEqual(presenter.getPhotos().first?.rover.name, FilterOption.spirit.title,
                      "Retrieved rover names should be equal to spirit.")
        XCTAssertFalse(presenter.wsErrorOccurredCalled,
                       "Error occured function shouldn't be called")
    }
}
