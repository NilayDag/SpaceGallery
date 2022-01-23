//
//  NSObject+Ext.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
