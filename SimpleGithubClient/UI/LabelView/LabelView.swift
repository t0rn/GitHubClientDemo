//
//  LabelView.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

@IBDesignable class LabelView : NibLoadingView , CellConfigurable {
    typealias Controller = LabelViewController
    
    @IBOutlet weak var label: UILabel!
    
    var cellController: LabelViewController?
    
}

