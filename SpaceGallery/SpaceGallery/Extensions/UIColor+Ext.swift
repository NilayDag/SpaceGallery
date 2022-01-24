//
//  UIColor+Ext.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import UIKit

extension UIColor {
    static func defaultColor() -> UIColor {
        UIColor.white
    }

    static var lightPeriwinkle: UIColor {
        UIColor(named: "light_periwinkle") ?? defaultColor()
    }

    static var paleGrey: UIColor {
        UIColor(named: "pale_grey") ?? defaultColor()
    }
}
