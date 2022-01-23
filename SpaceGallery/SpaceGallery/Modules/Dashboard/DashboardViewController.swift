//
//  DashboardViewController.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//  
//

import UIKit

class DashboardViewController: UIViewController, StoryboardLoadable {

    // MARK: Properties
    var presenter: IDashboardPresenter?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DashboardViewController: IDashboardView {
    // TODO: implement view output methods
}
