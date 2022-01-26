//
//  HTTPStubs+Ext.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 26.01.2022.
//

import OHHTTPStubs
import OHHTTPStubsSwift

extension HTTPStubs {
    public func stub(request: URLRequest, response: @escaping HTTPStubsResponseBlock) -> HTTPStubsDescriptor {
        let conditions = request.getHTTPStubsConditions()
        return HTTPStubs.stubRequests(passingTest: conditions.0 && conditions.1, withStubResponse: response)
    }
}

extension URLRequest {
    func getHTTPStubsConditions() -> (HTTPStubsTestBlock, HTTPStubsTestBlock) {
        let methotCondition: HTTPStubsTestBlock = getMethotAsHTTPStubsTestBlock()
        let absoluteURLStringCondition: HTTPStubsTestBlock = isAbsoluteURLString(self.url?.absoluteString ?? "nil")

        return (methotCondition, absoluteURLStringCondition)
    }

    private func getMethotAsHTTPStubsTestBlock() -> HTTPStubsTestBlock {
        switch self.method {
        case .get.self: return isMethodGET()
        // You may add other methods here.
        default: return isMethodGET()
        }
    }
}
