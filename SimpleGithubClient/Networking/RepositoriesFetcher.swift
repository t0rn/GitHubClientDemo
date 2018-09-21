//
//  RepositoriesFetcher.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit


final class RepositoriesFetcher : RepositoriesFetchable {
    
    let apiClient: GithibAPIClient
    weak var delegate: RepositoriesFetchableDelegate?
    
    init(apiClient:GithibAPIClient) {
        self.apiClient = apiClient
    }
    
    func fetchRepositories() {
        DispatchQueue.main.async {
            self.delegate?.state = .loading
        }

        apiClient.fetchRepositories { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    self?.delegate?.state = .success(repos)
                    break
                case .failure(let error):
                    self?.delegate?.state = .failure(error)
                    break
                }
            }
        }
    }
}

