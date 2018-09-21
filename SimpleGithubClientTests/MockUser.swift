//
//  MockUser.swift
//  SimpleGithubClientTests
//
//  Created by Alexey Ivanov on 21.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit
@testable import SimpleGithubClient

struct MockUser {
    static func user() -> User {
        let exampleURL = URL(string: "https://example.com")!
        let user = User(id: 007,
                        login: "login",
                        avatarURL: exampleURL,
                        url: exampleURL,
                        htmlURL: exampleURL,
                        followersURL: exampleURL,
                        type: "type",
                        reposURL: exampleURL)
        return user
    }
}
