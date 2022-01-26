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

    /**
     Sets up the cell with given image URL string.
     If not cached; downloads the image from the given url, otherwise retrieves the cached photo and sets it.
    
     - Parameters imageURLString: A string that represents the image URL string to set.
    */
    func setup(with imageURLString: String) {
        ImageManager.shared.downloadOrSetFromCache(from: imageURLString,
                                                   for: photoImageView)
    }
}
