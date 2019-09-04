//
//  UITableView+headerLayout.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 04/09/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import UIKit

extension UIView {
    ///Will set top, bottom, trailing and leading anchor
    ///constraints equals to containerView's
    func insert(into containerView:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive  = true
        leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive  = true
    }
}

extension UITableView {
    
    func insertHeaderView(_ view: UIView) {
        let frame = CGRect(x: 0.0, y: 0.0,
                           width: bounds.width,
                           height: view.bounds.height)
        
        let containerView = UIView(frame: frame)
        containerView.addSubview(view)
        view.insert(into: containerView)
        containerView.backgroundColor = .clear
        
        tableHeaderView = containerView
        layoutTableHeaderView()
    }
    
    //Variable-height UITableView tableHeaderView with autolayout
    func layoutTableHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerWidth = headerView.bounds.size.width
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]",
                                                                       options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)),
                                                                       metrics: ["width": headerWidth],
                                                                       views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
