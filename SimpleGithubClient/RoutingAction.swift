//
//  RoutingAction.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 22/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

struct RoutingAction: Action {
    let destination: RoutingDestination
}

struct RepoDetailsRoutingAction : Action {
    let destination: RoutingDestination = .repoDetails
    let repository:Repository
}
