//
//  PhotoGalleryCollectionViewAdapter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

class PhotoGalleryCollectionViewAdapter: NSObject {
    private let presenter: IDashboardPresenter
    private let view: IDashboardView

    init(view: IDashboardView, presenter: IDashboardPresenter) {
        self.view = view
        self.presenter = presenter
    }
}

extension PhotoGalleryCollectionViewAdapter {
    /**
     Returns the section count to show on the collection view.
    
     - Returns: An integer which represents the section count.
    */
    func sectionCount() -> Int {
        DashboardConstants.photoGallerySectionCount
    }

    /**
     Returns the number of items to show on the collection view for each section.
    
     - Returns: An integer which represents the number of items.
    */
    func numberOfItems() -> Int {
        getPhotos().count
    }

    /**
     Returns the photo items to show on the collection view.
    
     - Returns: A Photo array to show on the collection view.
    */
    func getPhotos() -> [Photo] {
        presenter.getPhotos()
    }
}

extension PhotoGalleryCollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Collection view data source
    /**
     Asks your data source object for the number of sections in the collection view.
    
     - Parameters collectionView: The collection view requesting this information.
    */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionCount()
    }

    /**
     Asks your data source object for the number of items in the specified section.
    
     - Parameters collectionView: The collection view requesting this information.
     - Parameters section: An index number identifying a section in collectionView. This index value is 0-based.
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems()
    }

    // swiftlint:disable:next line_length
    /**
     Asks your data source object for the cell that corresponds to the specified item in the collection view.

     - Parameters collectionView: The collection view requesting this information.
     - Parameters indexPath: The index path that specifies the location of the item.
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        setupPhotoCollectionViewCell(collectionView: collectionView, indexPath: indexPath)
    }

    // swiftlint:disable:next line_length
    /**
     Sets up the photo collection view cell.

     - Parameters collectionView: The collection view requesting this information.
     - Parameters indexPath: The index path that specifies the location of the item.
    */
    private func setupPhotoCollectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PhotoCollectionViewCell.nameOfClass
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? PhotoCollectionViewCell {
            cell.setup(with: getPhotos()[indexPath.row].imgSrc)
            return cell
        }
        return UICollectionViewCell()
    }

    /**
     Tells the delegate that the item at the specified index path was selected.

     - Parameters collectionView: The collection view requesting this information.
     - Parameters indexPath: The index path that specifies the location of the selected item.
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.photoItemPressed(with: getPhotos()[indexPath.row])
    }
}

extension PhotoGalleryCollectionViewAdapter: UIScrollViewDelegate {
    /**
     Tells the delegate when the user scrolls the content view within the receiver.

     - Parameters scrollView: The scroll-view object in which the scrolling occurred.
    */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        view.collectionViewScrolled(with: position)
    }
}
