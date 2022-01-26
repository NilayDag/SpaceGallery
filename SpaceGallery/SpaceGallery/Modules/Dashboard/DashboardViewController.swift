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
    /**
     A lifecycle method which is called after the view controller has loaded its view hierarchy into memory.
     Sets the initial setup functions implemented on view.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        commonInit()
    }

    /**
     A lifecycle method which notifies the view controller that its view is about to be added to a view hierarchy.
     Sets photoGalleryCollectionView's transform to its original state everytime view occures.
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoGalleryCollectionView.transform = .identity
    }

    /**
     A common initializer for the view. Sets the title and collection view.
    */
    private func commonInit() {
        title = DashboardConstants.title
        setupCollectionView()
    }

    /**
     Sets up the collection view's delegate, dataSource and registers its cell.
    */
    private func setupCollectionView() {
        photoGalleryCollectionView.delegate = adapter
        photoGalleryCollectionView.dataSource = adapter
        photoGalleryCollectionView.registerCell(PhotoCollectionViewCell.self)
    }

    /**
     Triggers when the filter button pressed. Calls presenter's button pressed method.
    */
    @IBAction private func onFilterButtonPressed() {
        presenter?.onFilterButtonPressed()
    }

    /**
     Triggers when the collection view pinched. Creates zoom effect by the help of the presenter's methods.
     
     - Parameters sender: UIPinchGestureRecognizer sender object.
    */
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
    /**
     Sets collection view's layout with given layout generator object.
     
     - Parameters generator: GalleryCollectionViewLayoutGenerator object that generates layout.
    */
    func setLayout(from generator: GalleryCollectionViewLayoutGenerator) {
        photoGalleryCollectionView.collectionViewLayout = generator.generateLayout()
    }

    /**
     Adds pinch gesture to the collection view in order to create zoom effect.
    */
    func addPinchGestureToCollectionView() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(collectionViewPinched(sender:)))
        photoGalleryCollectionView.addGestureRecognizer(pinch)
    }

    /**
     Reloads collection view when new data is fetched.
    */
    func reloadCollectionView() {
        photoGalleryCollectionView.reloadData()
    }

    /**
     Adds filtering button as a navigation rigth bar button item.
    */
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

    /**
     Sets given filtering options to filter the photos.
     
     - Parameters options: A FilterOptions array to show as filter options.
    */
    func setFilterOptions(to options: [FilterOption]) {
        popoverViewControler?.setupOptions(from: options)
        popoverViewControler?.delegate = self
        popoverViewControler?.modalPresentationStyle = .popover
    }

    /**
     Opens filter options popover when the navigation right bar button item is pressed.
    */
    func openFilterOptionsPopover() {
        guard let popoverPresentationController = popoverViewControler?.popoverPresentationController else { return }
        popoverPresentationController.delegate = self
        popoverPresentationController.barButtonItem = menuBarButtonItem
        present(popoverViewControler ?? UIViewController(), animated: true, completion: nil)
    }

    /**
     Hides filter options popover that presented.
    */
    func hideFilterOptionsPopover() {
        popoverViewControler?.dismiss(animated: true, completion: nil)
    }

    /**
     Shows empty state box in the middle of the screen when there are no photos to show.
    */
    func showEmptyState() {
        view.addSubview(emptyStateView)
    }

    /**
     Hides empty state view.
    */
    func hideEmptyState() {
        emptyStateView.removeFromSuperview()
    }

    /**
     Triggers when the collection view is scrolled. Calls presenter if neccessary in order to load more data.
     
     - Parameters position: A CGFloat object that holds the scroll position.
    */
    func collectionViewScrolled(with position: CGFloat) {
        // swiftlint:disable:next line_length
        if position > photoGalleryCollectionView.contentSize.height - DashboardConstants.minScrollValueForLoadMore - photoGalleryCollectionView.frame.size.height {
            presenter?.onLoadMore()
        }
    }

    /**
     Sets collection view transform after zoom.
     
     - Parameters transform: CGAffineTransform object to set as collection view transform.
    */
    func setCollectionViewTransform(to transform: CGAffineTransform) {
        photoGalleryCollectionView.transform = transform
    }
}

extension DashboardViewController: PopoverViewDelegate {
    /**
     PopoverViewDelegate method. Triggers when one of the filter option is pressed. Filters photos by given filter option.
     
     - Parameters sender: A FilterOption to filter photos.
    */
    func buttonPressed(_ sender: FilterOption) {
        presenter?.filterPhotos(with: sender)
    }
}

extension DashboardViewController: UIPopoverPresentationControllerDelegate {
    /**
     UIPopoverPresentationControllerDelegate method.
     Returns the presentation style to use when the presented view controller becomes horizontally compact.
     
     - Parameters controller: The value provided by the presentation controller’s delegate or UIModalPresentationStyle.
                         none if a delegate was not provided or does not return a valid value.
    */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
