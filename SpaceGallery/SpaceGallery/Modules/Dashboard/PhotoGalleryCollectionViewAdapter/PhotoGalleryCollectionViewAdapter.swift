//
//  PhotoGalleryCollectionViewAdapter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

class PhotoGalleryCollectionViewAdapter: NSObject {
    private let presenter: IDashboardPresenter

    init(presenter: IDashboardPresenter) {
        self.presenter = presenter
    }
}

extension PhotoGalleryCollectionViewAdapter {
    func sectionCount() -> Int {
        DashboardConstants.photoGallerySectionCount
    }

    func numberOfItems() -> Int {
        getPhotos().count
    }

    func getPhotos() -> [Photo] {
        presenter.getPhotos()
    }
}

extension PhotoGalleryCollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionCount()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems()
    }

    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        setupPhotoCollectionViewCell(collectionView: collectionView, indexPath: indexPath)
    }

    // swiftlint:disable:next line_length
    private func setupPhotoCollectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PhotoCollectionViewCell.nameOfClass
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? PhotoCollectionViewCell {
            cell.setup(with: getPhotos()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.photoItemPressed(with: getPhotos()[indexPath.row])
    }
}
