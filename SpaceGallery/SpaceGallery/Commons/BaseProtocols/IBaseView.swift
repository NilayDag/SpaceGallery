//
//  IBaseView.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import UIKit

protocol IBaseView: AnyObject {
    func showProgressHUD()
    func hideProgressHUD()
    func showErrorDialog(with message: String)
}

extension UIViewController: IBaseView {
    func resetNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    func showProgressHUD() {
        view.isUserInteractionEnabled = false
        LoadingManager.shared.showLoadingProgress()
    }

    func hideProgressHUD() {
        view.isUserInteractionEnabled = true
        LoadingManager.shared.hideLoadingProgress()
    }

    func showErrorDialog(with message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)

    }
}
