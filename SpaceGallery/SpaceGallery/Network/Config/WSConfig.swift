//
//  WSConfig.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import Foundation

struct WSConfig {
    static let baseURL: String = "https://api.nasa.gov/"
    static let jsonHeader: String = "application/json"
    static let solValue: Int = 1000
    static var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["NASA_API_KEY"] else { return "" }
        return apiKey
    }
}
