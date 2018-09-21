//
//  SimpleRepositoryCellController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

class SimpleRepositoryCellController : SimpleRepositoryCellRepresentable{
    let fullname: String
    let descr: String?
    
    init(_ repository: Repository) {
        self.fullname = repository.fullname
        self.descr = repository.descr
    }
}
