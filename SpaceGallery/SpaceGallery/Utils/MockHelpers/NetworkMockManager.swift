//
//  NetworkMockManager.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

protocol StubHelperProtocol {
    var stubName: String { get }
    func loadStubs()
    func loadFailStubs()
    func unloadStubs()
}

extension StubHelperProtocol {
    func loadFailStubs() {}
}

class NetworkMockManager {
    static let shared = NetworkMockManager()

    init() {
        HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
            print(
                "📢 [OHHTTPStubs] Request to \(String(describing: request.url)) has been stubbed with \(String(describing: stub.name)) 📢"
                // swiftlint:disable:previous line_length
            )
        }
    }

    func loadRequiredStubs() {
        RetrieveCuriosityPhotosRequestStubs.shared.loadStubs()
        RetrieveOpportunityPhotosRequestStubs.shared.loadStubs()
        RetrieveSpiritPhotosRequestStubs.shared.loadStubs()
    }

    func removeAllStubs() {
        HTTPStubs.removeAllStubs()
    }

    func resetAllStubs() {
        HTTPStubs.removeAllStubs()
        loadRequiredStubs()
    }
}
