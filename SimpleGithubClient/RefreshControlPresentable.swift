//
//  RefreshControlPresentable.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 04/09/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import Foundation

public protocol RefreshControlPresentable {
    func endRefreshing()
    func beginRefreshing()
}
