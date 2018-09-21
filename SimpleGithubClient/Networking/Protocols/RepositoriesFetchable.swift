//
//  RepositoriesFetchable.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

protocol RepositoriesFetchable {
    func fetchRepositories()
    var delegate:RepositoriesFetchableDelegate? {get set}
}
