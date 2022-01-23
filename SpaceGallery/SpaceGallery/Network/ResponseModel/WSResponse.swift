//
//  WSResponse.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import Foundation

// MARK: - NASAAPICommonResponse
struct WSResponse<T: Decodable> {
    let results: T?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - NASAAPICommonError
struct WSError: Decodable {
    let code: String?
    let message: String?
}
