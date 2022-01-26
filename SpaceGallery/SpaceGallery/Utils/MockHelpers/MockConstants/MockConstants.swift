//
//  MockConstants.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation

struct MockConstants {
    enum Stubs {
        case retrievePhotos(page: Int, filterOption: String)
        var responseJSONFileName: String {
            switch self {
            case .retrievePhotos(_, let filterOption):
                switch filterOption {
                case FilterOption.curiosity.rawValue:
                    return "curiosityPhotos.json"
                case FilterOption.opportunity.rawValue:
                    return "opportunityPhotos.json"
                case FilterOption.spirit.rawValue:
                    return "spiritPhotos.json"
                default: return "curiosityPhotos.json"
                }
            }
        }
        var name: String {
            switch self {
            case .retrievePhotos(_, let filterOption):
                switch filterOption {
                case FilterOption.curiosity.rawValue:
                    return "retrieveCuriosityPhotosRequestStubs"
                case FilterOption.opportunity.rawValue:
                    return "retrieveOpportunityPhotosRequestStubs"
                case FilterOption.spirit.rawValue:
                    return "retrieveSpiritPhotosRequestStubs"
                default: return "curiosityPhotos.json"
                }
            }
        }
    }

    // swiftlint:disable:next line_length
    static let curiosityPhotosURLString: String = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY&page=1"

    // swiftlint:disable:next line_length
    static let opportunityPhotosURLString: String = "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=1000&api_key=DEMO_KEY&page=1"
    
    // swiftlint:disable:next line_length
    static let spiritPhotosURLString: String = "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?api_key=dkqX6PuubAX2Eu3ajUhNyDvIDKefnQsSfE0WubYV&page=1&sol=1000"
}
