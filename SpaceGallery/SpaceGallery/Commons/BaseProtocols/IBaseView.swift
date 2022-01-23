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
    func showProgressHUD() {
        LoadingManager.shared.showLoadingProgress()
    }

    func hideProgressHUD() {
        LoadingManager.shared.hideLoadingProgress()
    }

    func showErrorDialog(with message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)

    }
}
