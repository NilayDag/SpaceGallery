//
//  DashboardViewMock.swift
//  SpaceGalleryTests
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import UIKit

@testable import SpaceGallery
public class DashboardViewMock: IDashboardView {
    // MARK: Properties
    var isProgressShowing = false

    // MARK: Called Properties
    var showErrorDialogCalled = false
    var reloadCollectionViewCalled = false
    var setLayoutCalled = false
    var addFilteringButtonCalled = false
    var setFilterOptionsCalled = false
    var openFilterOptionsPopoverCalled = false
    var hideFilterOptionsPopoverCalled = false
    var collectionViewScrolledCalled = false
    
    public func showProgressHUD() {
        isProgressShowing = true
    }

    public func hideProgressHUD() {
        isProgressShowing = false
    }

    public func showErrorDialog(with message: String) {
        showErrorDialogCalled = true
    }

    public func reloadCollectionView() {
        reloadCollectionViewCalled = true
    }
    
    public func setLayout(from generator: GalleryCollectionViewLayoutGenerator) {
        setLayoutCalled = true
    }
    
    public func addFilteringButton() {
        addFilteringButtonCalled = true
    }
    
    public func setFilterOptions(to options: [FilterOption]) {
        setFilterOptionsCalled = true
    }
    
    public func openFilterOptionsPopover() {
        openFilterOptionsPopoverCalled = true
    }
    
    public func hideFilterOptionsPopover() {
        hideFilterOptionsPopoverCalled = true
    }
    
    public func collectionViewScrolled(with position: CGFloat) {
        collectionViewScrolledCalled = true
    }
}
