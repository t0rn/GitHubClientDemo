//
//  APIClient.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


protocol APIClient {
    var sessionConfig: URLSessionConfiguration {get}
    var session: URLSession {get}
    
    func dataTask<T:APIModel>(model:T.Type, request:URLRequest, completion:@escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
    
    func fetch<T:APIModel>(model:T.Type, request: URLRequest,completion: @escaping (Result<[T]>) -> Void)
}

extension APIClient {

    var session:URLSession {
        return URLSession(configuration: sessionConfig)
    }
    
    var sessionConfig: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    func dataTask<T:APIModel>(model:T.Type, request:URLRequest, completion:@escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask {
        return session.dataTask(with: request, completionHandler: completion)
    }
    
    func fetch<T:APIModel>(model:T.Type, request: URLRequest,completion: @escaping (Result<[T]>) -> Void) {
        let task = dataTask(model: model, request: request) { (data, response, error) in
            //here we check that if we don't have connection,
            //then try to use cache
            if let error = error as NSError?,
                error.code == NSURLErrorNotConnectedToInternet {
                //copy request and change cache policy
                var req = request
                req.cachePolicy = .returnCacheDataDontLoad
                self.fetch(model: model, request: req, completion: completion)
                return
            }
            
            //other type of errors should be handled too
            if let error = error {
                completion(Result.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(Result.failure(APIErrors.wrongResponseCode(response.statusCode)))
                return
            }
            guard let data = data else {
                completion(Result.failure(APIErrors.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                completion(Result.success(result))
            }catch {
                completion(Result.failure(error))
            }
        }
        task.resume()
    }
}
