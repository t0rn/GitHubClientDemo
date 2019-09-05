//
//  ImageFetcher.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 18.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

final class ImageFetcher  : ImageFetchable {
    
    enum Errors: Error {
        case unsupportedData
    }
    
    private let session: URLSession
    
    init(session:URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(_ url:URL,
                    cachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy,
                    completion:@escaping (Result<UIImage>) -> Void) {
        let req = URLRequest(url: url, cachePolicy: cachePolicy )
        let task = session.dataTask(with: req) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(.failure(APIErrors.wrongResponseCode(response.statusCode)))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIErrors.noData))
                    return
                }
                guard let image = UIImage(data: data) else {
                    completion(.failure(Errors.unsupportedData))
                    return
                }
                completion(.success(image))
            }
        }
        task.resume()
    }
}


