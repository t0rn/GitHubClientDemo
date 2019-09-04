//
//  ReposListReducer.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 22/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

func reposListReducer(action: Action, state: ReposListState?) -> ReposListState {
    var state = state ?? ReposListState(showLoading: false, repos: nil)
    switch action {
    case _ as FetchReposAction:
        state.showLoading = true
    case let setReposAction as SetReposAction:
        state.repos = setReposAction.repositories
    default: break
    }
    return state
}

struct SetReposAction : Action {
    let repositories: [Repository]
}

