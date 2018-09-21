//
//  Repository.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

typealias APIModel = Codable

struct Repository : APIModel {
    let id: Int
    let name: String
    let fullname:String
    let htmlURL: URL

    //don't use "description"
    let descr: String?
    let owner: User
    let stargazersURL: URL
    let subscribersURL: URL
    let forksURL: URL
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case owner
        case fullname = "full_name"
        case htmlURL = "html_url"
        case descr = "description"
        case subscribersURL = "subscribers_url"
        case stargazersURL = "stargazers_url"
        case forksURL = "forks_url"
    }
}

extension Repository : Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}
