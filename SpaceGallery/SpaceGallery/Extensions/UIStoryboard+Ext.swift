//
//  UIStoryboard+Ext.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import UIKit

extension UIStoryboard {
    static func loadViewController<T>() -> T where T: StoryboardLoadable, T: UIViewController {
        return UIStoryboard(name: T.storyboardName(),
                            bundle: nil).instantiateViewController(withIdentifier: T.storyboardIdentifier()) as! T
        // swiftlint:disable:previous force_cast
    }
}
