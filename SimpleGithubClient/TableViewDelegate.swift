//
//  TableViewDelegate.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 05/09/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import UIKit

class TableViewDelegate<Model> : NSObject, UITableViewDelegate {
    private let models:[Model]
    private let didSelectItem:((Model)->Void)?
    
    init(models:[Model], didSelectItem:((Model)->Void)? = nil) {
        self.models = models
        self.didSelectItem = didSelectItem
        super.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        didSelectItem?(model)
    }
}
