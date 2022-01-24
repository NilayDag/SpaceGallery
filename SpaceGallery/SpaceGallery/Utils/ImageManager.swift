//
//  ImageManager.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import Foundation
import SDWebImage

final class ImageManager: NSObject {
    static let shared = ImageManager()

    private override init() { }

    func downloadOrSetFromCache(from url: String?, for imageView: UIImageView) {
        guard let downloadURL = url, downloadURL.isValidURL() else {
            print("IDM Error: Given URL String is either nil, unusable or not a valid url.")
            return
        }
        setImage(url: URL(string: downloadURL),
                 imageView: imageView,
                 placeHolder: nil,
                 options: .progressiveLoad)
    }

    private func setImage(url: URL?, imageView: UIImageView, placeHolder: UIImage?, options: SDWebImageOptions) {
        /*
         Downloads the image at the given URL if not present in cache or return the cached version otherwise.

         - parameters:
         - url: The URL to the image
         - placeholder: A placeholder for the image
         - options: A mask to specify options to use for this request
         - progressBlock: A block called while image is downloading
         - completedBlock: A block called when operation has been completed.
         */
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: url!,
                              placeholderImage: placeHolder,
                              options: options) { (downloadedImage, _, _, _) in
            if downloadedImage != nil {
                imageView.image = downloadedImage
            } else {
                // No image exists.
            }
        }
    }
}
