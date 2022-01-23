//
//  APIProvider.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import Foundation
import Alamofire

class APIProvider: NSObject {

    static var shared: APIProvider = APIProvider()
    fileprivate var session = AF

    typealias OnSuccess<T: Decodable> = ((WSResponse<T>) -> Void)?
    typealias OnError = ((WSError?) -> Void)

    private override init() {
        super.init()
        session = Session()
    }

    @discardableResult
    func performRequest<T: Decodable>(route: APIRouter,
                                      decoder: DataDecoder = JSONDecoder(),
                                      onSuccess: OnSuccess<T>,
                                      onError: OnError? = nil) -> DataRequest {
        return getRequest(route, decoder, onSuccess, onError)
    }

    func getRequest<T: Decodable>(_ route: URLRequestConvertible,
                                  _ decoder: DataDecoder = JSONDecoder(),
                                  _ onSuccess: OnSuccess<T>,
                                  _ onError: OnError? = nil) -> DataRequest {
        return session.request(route)
                      .validate(statusCode: 200..<400)
                      .validate(contentType: [WSConfig.jsonHeader])
                      .responseDecodable(of: T.self, decoder: decoder) { (requestResponse) in
                switch requestResponse.result {
                case .success:
                    onSuccess?(WSResponse(results: requestResponse.value))
                case .failure:
                    guard onError != nil else {
                        guard let onError = onError else {
                            onSuccess?(WSResponse(results: nil))
                            return
                        }
                        do {
                            guard let data = requestResponse.data else { return onError(nil) }
                            let wsError = try JSONDecoder().decode(WSError.self, from: data)
                            onError(wsError)
                        } catch _ {
                            onError(nil)
                            // TODO: May log the casting error
                        }
                        onError(nil)
                        return
                    }
                }
        }
    }
}
