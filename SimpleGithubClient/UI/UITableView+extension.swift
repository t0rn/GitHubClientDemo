//
//  UITableView+extension.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 18.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

extension UITableView {
    func registerReusableCell<T:UITableViewCell & ReusableCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
