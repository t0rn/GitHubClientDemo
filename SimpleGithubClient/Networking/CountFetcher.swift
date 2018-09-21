//
//  CountFetcher.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

class CountFetcher<T:APIModel> {
    weak var delegate: StringFetcherDelegate?
    
    let apiClient: GithibAPIClient
    
    init(apiClient:GithibAPIClient) {
        self.apiClient = apiClient
    }
    
    func fetchCount(from endpoint:Endpoint) {
        DispatchQueue.main.async {
            self.delegate?.state = .loading
        }
        apiClient.fetch(model: T.self, request: endpoint.request) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.delegate?.state = .success(String(models.count))
                    break
                case .failure(let error):
                    self?.delegate?.state = .failure(error)
                    break
                }
            }
        }
    }
}
