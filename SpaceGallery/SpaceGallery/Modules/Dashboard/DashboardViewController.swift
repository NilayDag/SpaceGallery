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
    var menuBarButtonItem: UIBarButtonItem?
    var popoverViewControler: PopoverViewController? = UIStoryboard.loadViewController() as PopoverViewController

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

    @objc private func onFilterButtonPressed() {
        presenter?.onFilterButtonPressed()
    }
}

extension DashboardViewController: IDashboardView {
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator) {
        photoGalleryCollectionView.collectionViewLayout = generator.generateLayout()
    }

    func reloadCollectionView() {
        photoGalleryCollectionView.reloadData()
    }

    func addFilteringButton() {
        guard let menuIcon = UIImage(named: DashboardConstants.menuIconName) else { return }
        let filterButton = UIBarButtonItem(image: menuIcon,
                                           style: .plain,
                                           target: self,
                                           action: #selector(onFilterButtonPressed))
        menuBarButtonItem = filterButton
        filterButton.tintColor = .black
        navigationItem.rightBarButtonItem = filterButton
    }

    func showFilteringOptions(with options: [FilterOptions]) {
        popoverViewControler?.setupOptions(from: options)
        popoverViewControler?.delegate = self
        popoverViewControler?.modalPresentationStyle = .popover
        guard let popoverPresentationController = popoverViewControler?.popoverPresentationController else { return }
        popoverPresentationController.barButtonItem = menuBarButtonItem
        popoverPresentationController.delegate = self
        self.present(popoverViewControler ?? UIViewController(), animated: true, completion: nil)
    }
}

extension DashboardViewController: PopoverViewDelegate {
    func buttonPressed(_ sender: FilterOptions) {
        print("here w sender: \(sender)")
        // TODO: filter photos with sender
    }
}

extension DashboardViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
