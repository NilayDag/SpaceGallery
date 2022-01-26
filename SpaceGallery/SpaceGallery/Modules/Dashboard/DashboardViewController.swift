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
    private lazy var emptyStateView: EmptyStateView = {
        let emptyState = EmptyStateView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: DashboardConstants.emptyStateViewWidth,
                                                      height: DashboardConstants.emptyStateViewHeight))
        emptyState.center = view.center
        return emptyState
    }()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoGalleryCollectionView.transform = .identity
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

    @IBAction private func onFilterButtonPressed() {
        presenter?.onFilterButtonPressed()
    }

    @IBAction private func collectionViewPinched(sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed,
            presenter?.getPhotos().count ?? 0 > 0 {
            presenter?.onCollectionViewPinched(sender: sender,
                                             with: photoGalleryCollectionView.frame.size.width,
                                             photoGalleryCollectionView.bounds.size.width)
        }
    }
}

extension DashboardViewController: IDashboardView {
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator) {
        photoGalleryCollectionView.collectionViewLayout = generator.generateLayout()
    }

    func addPinchGestureToCollectionView() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(collectionViewPinched(sender:)))
        photoGalleryCollectionView.addGestureRecognizer(pinch)
    }

    func reloadCollectionView() {
        photoGalleryCollectionView.reloadData()
    }

    func addFilteringButton() {
        guard let menuIcon = UIImage(named: DashboardConstants.menuIconName) else { return }
        let filterButton = UIBarButtonItem(image: menuIcon,
                                           style: .plain,
                                           target: self,
                                           action: #selector(onFilterButtonPressed))
        menuBarButtonItem = filterButton
        filterButton.tintColor = .black
        navigationItem.rightBarButtonItem = filterButton
    }

    func setFilterOptions(to options: [FilterOption]) {
        popoverViewControler?.setupOptions(from: options)
        popoverViewControler?.delegate = self
        popoverViewControler?.modalPresentationStyle = .popover
    }

    func openFilterOptionsPopover() {
        guard let popoverPresentationController = popoverViewControler?.popoverPresentationController else { return }
        popoverPresentationController.delegate = self
        popoverPresentationController.barButtonItem = menuBarButtonItem
        present(popoverViewControler ?? UIViewController(), animated: true, completion: nil)
    }

    func hideFilterOptionsPopover() {
        popoverViewControler?.dismiss(animated: true, completion: nil)
    }

    func showEmptyState() {
        view.addSubview(emptyStateView)
    }

    func hideEmptyState() {
        emptyStateView.removeFromSuperview()
    }

    func collectionViewScrolled(with position: CGFloat) {
        // swiftlint:disable:next line_length
        if position > photoGalleryCollectionView.contentSize.height - DashboardConstants.minScrollValueForLoadMore - photoGalleryCollectionView.frame.size.height {
            presenter?.onLoadMore()
        }
    }

    func setCollectionViewTransform(to transform: CGAffineTransform) {
        photoGalleryCollectionView.transform = transform
    }
}

extension DashboardViewController: PopoverViewDelegate {
    func buttonPressed(_ sender: FilterOption) {
        presenter?.filterPhotos(with: sender)
    }
}

extension DashboardViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
