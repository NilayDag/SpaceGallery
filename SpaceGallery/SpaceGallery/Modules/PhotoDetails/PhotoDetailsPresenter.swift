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
    /**
     A lifecycle method triggered from view which is called after
     the view controller has loaded its view hierarchy into memory.
     Sets the initial setup functions implemented on view
    */
    func viewDidLoad() {
        guard let photo = photoItem else { return }
        view?.setUIElements(with: photo)
    }

    /**
     Sets photo detail item to show on the screen.
    
     - Parameters item: A Photo item to show details.
    */
    func setPhotoItem(to item: Photo) {
        photoItem = item
    }
}
