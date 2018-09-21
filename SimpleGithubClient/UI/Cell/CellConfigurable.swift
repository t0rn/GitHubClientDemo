//
//  CellConfigurable.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


protocol CellConfigurable: class {
    associatedtype Controller
    
    var cellController: Controller? { get set }
}
