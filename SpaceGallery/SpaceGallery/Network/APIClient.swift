//
//  APIClient.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 23.01.2022.
//

import Alamofire

protocol APIClientInterface {
    typealias OnSuccess<T: Decodable> = ((WSResponse<T>) -> Void)
    typealias OnError = ((WSError?) -> Void)?

    func retrievePhotos(page: Int,
                        onSuccess: @escaping OnSuccess<PhotoList>,
                        onError: OnError)
}

class APIClient: APIClientInterface {
    func retrievePhotos(page: Int,
                        onSuccess: @escaping OnSuccess<PhotoList>,
                        onError: OnError) {
        APIProvider.shared.performRequest(route: .retrievePhotos(page: page),
                                          onSuccess: onSuccess,
                                          onError: onError)
    }
}
