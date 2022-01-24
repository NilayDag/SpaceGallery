//
//  PhotoDetailsContract.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//  
//

import Foundation

protocol IPhotoDetailsView: IBaseView {
    func setUIElements(with photoItem: Photo)
}

protocol IPhotoDetailsPresenter: IBasePresenter {
    func setPhotoItem(to item: Photo)
}
