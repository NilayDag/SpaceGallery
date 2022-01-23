//
//  DashboardViewController.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import UIKit

class DashboardViewController: UIViewController, StoryboardLoadable {

    // MARK: - IBOutlets
    @IBOutlet private weak var photoGalleryCollectionView: UICollectionView!

    // MARK: - Properties
    var presenter: IDashboardPresenter?
    var adapter: PhotoGalleryCollectionViewAdapter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        commonInit()
    }

    private func commonInit() {
        title = DashboardConstants.title
        setupCollectionView()
    }

    private func setupCollectionView() {
        photoGalleryCollectionView.delegate = adapter
        photoGalleryCollectionView.dataSource = adapter
        photoGalleryCollectionView.register(PhotoCollectionViewCell.self,
                                            forCellWithReuseIdentifier: PhotoCollectionViewCell.nameOfClass)
    }
}

extension DashboardViewController: IDashboardView {
    // TODO: implement view output methods
}
