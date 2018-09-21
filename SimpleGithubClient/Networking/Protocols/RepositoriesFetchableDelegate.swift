//
//  RepositoriesFetchableDelegate.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

protocol RepositoriesFetchableDelegate : class {
    var state: FetchingState<Array<Repository>> {get set}
}
