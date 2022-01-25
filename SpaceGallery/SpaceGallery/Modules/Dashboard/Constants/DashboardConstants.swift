//
//  DashboardConstants.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 24.01.2022.
//

import Foundation

struct DashboardConstants {
    static let photoGallerySectionCount: Int = 3
    static let title: String =  "Photos"
    static let menuIconName: String = "icon_menu"
}

enum FilterOptions: CaseIterable {
    case curiosity, opportunity, spirit

    var title: String {
        switch self {
        case .curiosity: return "Curiosity"
        case .opportunity: return "Opportunity"
        case .spirit: return "Spirit"
        }
    }
}
