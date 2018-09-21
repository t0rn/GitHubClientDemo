//
//  GithibAPIClient.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


class GithibAPIClient : APIClient {
    
    func fetchRepositories(with request:URLRequest = GithubEndpoints.repositories(since: nil).request,
                           completion: @escaping (Result<[Repository]>) -> Void) {
        fetch(model: Repository.self, request: request, completion: completion)
    }
    
    func dataTask<T:APIModel>(model:T.Type, request:URLRequest, completion:@escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask {
        return session.dataTask(with: request, completionHandler: completion)
    }

}


