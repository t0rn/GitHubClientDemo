//
//  MockRepository.swift
//  SimpleGithubClientTests
//
//  Created by Alexey Ivanov on 21.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit
@testable import SimpleGithubClient


struct MockRepository {
    static func repository() -> Repository {
        let exampleURL = URL(string: "https://example.com")!
        let repo = Repository(id: 123,
                              name: "name",
                              fullname: "fullname",
                              htmlURL: exampleURL,
                              descr: nil,
                              owner: MockUser.user(),
                              stargazersURL: exampleURL,
                              subscribersURL: exampleURL,
                              forksURL: exampleURL)
        return repo
    }
}
