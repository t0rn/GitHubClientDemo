//
//  User.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 18.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


struct User : APIModel {
    let id: Int
    let login: String
    let avatarURL: URL
    let url: URL
    let htmlURL: URL
    let followersURL:URL
    let type: String
    let reposURL: URL
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case login
        case url
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case type
        case reposURL = "repos_url"
    }
}
