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

    func setup(with imageURLString: String) {
        ImageManager.shared.downloadOrSetFromCache(from: imageURLString,
                                                   for: photoImageView)
    }
}
