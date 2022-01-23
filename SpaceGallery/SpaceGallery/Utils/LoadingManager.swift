//
//  LoadingManager.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import UIKit

class LoadingManager: NSObject {
    static let shared = LoadingManager()
    private var indicator = UIActivityIndicatorView()

    private override init() {
        super.init()
        setupLoadingIndicator()
    }

    func setupLoadingIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        if let window = AppRouter.shared.window,
           let topMostViewController = window.rootViewController {
            indicator.center = topMostViewController.view.center
            topMostViewController.view.addSubview(indicator)
        }
    }

    func showLoadingProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }

    func hideLoadingProgress() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}
