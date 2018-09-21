//
//  StringFetcherDelegate.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

protocol StringFetcherDelegate : class {
    var state: FetchingState<String> {get set}
}
