//
//  GithubEndpoints.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

enum GithubEndpoints {
    case repositories(since:String?)
    case subscribers(Repository)
    case forks(Repository)
    case stargazers(Repository)
}

extension GithubEndpoints : Endpoint {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String? {
        switch self {
        case .repositories(since: _):
            return "repositories"
        case .forks(let repo):
            return repo.forksURL.path
        case .stargazers(let repo):
            return repo.stargazersURL.path
        case .subscribers(let repo):
            return repo.subscribersURL.path
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .repositories(since: _),
             .stargazers(_),
             .forks(_),
             .subscribers(_):
            return .GET
        }
    }
    
    var header: [String : String]? {
        return ["Accept":"application/vnd.github.v3+json"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .repositories(since: let since):
            guard let since = since else { return nil }
            return ["since":since]
        case .forks(_),
             .subscribers(_),
             .stargazers(_):
            return nil
        }
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.useProtocolCachePolicy
    }
}



