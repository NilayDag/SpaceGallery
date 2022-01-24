//
//  PhotoCollectionViewCell.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var photoImageView: UIImageView!

    // MARK: - Properties
    private var photo: Photo?

    func setup(with item: Photo) {
        photo = item
        ImageManager.shared.downloadOrSetFromCache(from: item.imgSrc,
                                                   for: photoImageView)
    }
}
