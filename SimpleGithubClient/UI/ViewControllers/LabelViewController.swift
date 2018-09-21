//
//  LabelViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 20.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit


class LabelViewController :  StringFetcherDelegate {
    let labelView:LabelView
    let title:String
    
    init(labelView:LabelView,title:String) {
        self.labelView = labelView
        self.title = title
        setupLabel()
    }
    
    func setupLabel() {
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 5.0
    }
    
    var state: FetchingState<String> = .loading {
        willSet{
            update(with: newValue)
        }
    }
    
    func update(with newState: FetchingState<String>){
        switch (state,newState) {
        case (_,.loading):
            labelView.label.text = title + ": " + "..."
            break
        case (_, .failure(let error)):
            labelView.label.text = error.localizedDescription
            print(error)
            break
        case (_,.success(let string)):
            labelView.label.text = title + ": " + string
            break
        }
    }
}
