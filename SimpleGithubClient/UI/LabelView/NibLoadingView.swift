//
//  NibLoadingView.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

 @IBDesignable class NibLoadingView: UIView {
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
}
