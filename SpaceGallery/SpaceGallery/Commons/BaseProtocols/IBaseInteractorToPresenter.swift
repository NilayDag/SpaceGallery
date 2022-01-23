//
//  IBaseInteractorToPresenter.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import Foundation

protocol IBaseInteractorToPresenter: AnyObject {
    func wsErrorOccurred(with message: String)
}
