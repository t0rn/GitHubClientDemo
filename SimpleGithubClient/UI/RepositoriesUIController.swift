//
//  RepositoriesUIController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

protocol ErrorPresentable : class {
    func shouldPresent(error:Error)
}


