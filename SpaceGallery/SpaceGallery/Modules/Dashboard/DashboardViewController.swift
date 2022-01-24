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
        photoGalleryCollectionView.registerCell(PhotoCollectionViewCell.self)
    }
}

extension DashboardViewController: IDashboardView {
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator) {
        photoGalleryCollectionView.collectionViewLayout = generator.generateLayout()
    }

    func reloadCollectionView() {
        photoGalleryCollectionView.reloadData()
    }
}
