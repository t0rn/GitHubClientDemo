//
//  ReposListState.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 22/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

struct ReposListState: StateType {
    var showLoading:Bool
    var repos:[Repository]?
}
