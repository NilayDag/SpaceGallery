//
//  UICollectionView+Ext.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

extension UICollectionView {
    private func nibFromClass(_ type: UICollectionReusableView.Type) -> UINib {
        return UINib(nibName: type.nameOfClass, bundle: nil)
    }

    func registerCell<T: UICollectionReusableView>(_ cell: T.Type) {
        register(nibFromClass(cell), forCellWithReuseIdentifier: cell.nameOfClass)
    }
}
