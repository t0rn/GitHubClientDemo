//
//  APIErrors.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

enum APIErrors: Error {
    case noData
    case wrongResponseCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data in response"
        case .wrongResponseCode(let code):
            return "Response code: \(code)"
        }
    }
}

