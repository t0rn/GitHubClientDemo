//
//  BaseTableViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 04/09/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import UIKit

public protocol BaseTableViewControllerDelegate : class {
    
}

public protocol BaseTableViewProtocol {
    var tableDelegate: UITableViewDelegate? {get set}
    var tableDataSource: UITableViewDataSource? {get set}
    var headerView:UIView? {get set}
    var backgroundView:UIView? {get set}
    
    func reloadData()
}

open class BaseTableViewController: UITableViewController, BaseTableViewProtocol, RefreshControlPresentable {
    
    // keep a strong reference to the data source
    public var tableDataSource:UITableViewDataSource? {
        didSet {
            guard isViewLoaded else {return}
            tableView.dataSource = tableDataSource
        }
    }
    
    //and delegate
    public var tableDelegate:UITableViewDelegate? {
        didSet{
            guard isViewLoaded else {return}
            tableView.delegate = tableDelegate
        }
    }
    
    ///Table header view
    public var headerView: UIView? {
        didSet{
            guard isViewLoaded else { return }
            guard let headerView = headerView else {
                tableView.tableHeaderView = nil
                tableView.layoutTableHeaderView()
                return
            }
            tableView.insertHeaderView(headerView)
            tableView.layoutTableHeaderView()
        }
    }
    
    public var backgroundView:UIView? {
        didSet {
            guard isViewLoaded else {return}
            tableView.backgroundView = backgroundView
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = makeRefreshControl()
    }
    
    open func reloadData() {
        guard isViewLoaded else {return}
        tableView.reloadData()
    }
    
    @objc open func refreshControlValueChanged() {
        
    }
    
    //MARK: RefreshControlPresentable
    
    public func endRefreshing() {
        refreshControl?.endRefreshing()
    }
    
    public func beginRefreshing() {
        refreshControl?.beginRefreshing()
    }
    
    private func makeRefreshControl() -> UIRefreshControl {
        let rc = UIRefreshControl(frame: .zero)
        rc.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        return rc
    }
}


