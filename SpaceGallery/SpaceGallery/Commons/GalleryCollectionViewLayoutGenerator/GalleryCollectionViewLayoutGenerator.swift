//
//  GalleryCollectionViewLayoutGenerator.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

final class GalleryCollectionViewLayoutGenerator {
    func generateLayout() -> UICollectionViewCompositionalLayout {
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                           heightDimension: .fractionalHeight(1.0)))
      let group = NSCollectionLayoutGroup
                  .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                 heightDimension: .fractionalWidth(1/3)),
                              subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }
}
