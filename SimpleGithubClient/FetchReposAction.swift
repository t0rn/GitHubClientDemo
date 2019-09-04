//
//  FetchReposAction.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 24/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

func fetchReposAction() -> FetchReposAction {
    GithibAPIClient().fetchRepositories { (result) in
        switch result {
        case .success(let repos):
            store.dispatch(SetReposAction(repositories: repos))
        case .failure(let error):
            store.dispatch( SetErrorAction(error: error) )
        }
    }
    return FetchReposAction()
}


struct FetchReposAction : Action {
    
}

struct SetErrorAction : Action {
    let error: Error
}
