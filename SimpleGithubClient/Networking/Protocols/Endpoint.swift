//
//  Endpoint.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


protocol Endpoint {
    var url: URL {get}
    var request: URLRequest {get}
    var baseURL: URL {get}
    var header: [String: String]? {get}
    var path: String? {get}
    var parameters: [String : Any]? {get}
    var method: HTTPMethods {get}
    var cachePolicy: URLRequest.CachePolicy {get}
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        guard var components = URLComponents(string: baseURL.absoluteString) else {
            fatalError("Can't init URLComponents for \(baseURL.absoluteString)")
        }
        if var path = path {
            if path.first != "/" { path = "/" + path }
            components.path += path
        }
        return components
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.useProtocolCachePolicy
    }
    
    var url: URL {
        guard let url = urlComponents.url else {
            fatalError("Can't create an URL using URLComponents: \(urlComponents)")
        }
        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        //TODO: add request body parameters
//        request.httpBody
        request.cachePolicy = cachePolicy
        header?.forEach({ request.setValue($0.value, forHTTPHeaderField: $0.key)})
        return request
    }
}
