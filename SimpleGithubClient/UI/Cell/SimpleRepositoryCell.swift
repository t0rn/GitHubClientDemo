//
//  SimpleRepositoryCell.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

class SimpleRepositoryCell : UITableViewCell, ReusableCell, CellConfigurable {
    typealias Controller = SimpleRepositoryCellController
    
    var cellController: SimpleRepositoryCellController? {
        didSet{
            guard let controller = cellController else {return}
            textLabel?.text = controller.fullname
            detailTextLabel?.text = controller.descr
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

