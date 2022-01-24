//
//  PhotoDetailsPresenter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//  
//

import Foundation

class PhotoDetailsPresenter {

    // MARK: - Properties
    weak var view: IPhotoDetailsView?
    private var photoItem: Photo?
}

extension PhotoDetailsPresenter: IPhotoDetailsPresenter {
    func viewDidLoad() {
        guard let photo = photoItem else { return }
        view?.setUIElements(with: photo)
    }

    func setPhotoItem(to item: Photo) {
        photoItem = item
    }
}
