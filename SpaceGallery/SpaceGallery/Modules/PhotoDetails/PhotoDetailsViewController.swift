//
//  PhotoDetailsViewController.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//  
//

import UIKit

class PhotoDetailsViewController: UIViewController, StoryboardLoadable {
    // MARK: - IBOutlets
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblVehicleName: UILabel!
    @IBOutlet private weak var lblCameraType: UILabel!
    @IBOutlet private weak var lblMissionStatus: UILabel!
    @IBOutlet private weak var lblLaunchDate: UILabel!
    @IBOutlet private weak var lblLandingDate: UILabel!

    // MARK: - Properties
    var presenter: IPhotoDetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        resetNavigationBar()
    }
}

extension PhotoDetailsViewController: IPhotoDetailsView {
    func setUIElements(with photoItem: Photo) {
        ImageManager.shared.downloadOrSetFromCache(from: photoItem.imgSrc,
                                                   for: photoImageView)
        lblDate.text = photoItem.earthDate
        lblVehicleName.text = photoItem.rover.name
        lblCameraType.text = photoItem.camera.fullName
        lblMissionStatus.text = photoItem.rover.status
        lblLaunchDate.text = photoItem.rover.launchDate
        lblLandingDate.text = photoItem.rover.landingDate
    }
}
