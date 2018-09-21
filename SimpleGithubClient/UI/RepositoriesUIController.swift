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

protocol RepositoriesUIControllerDelegate: ErrorPresentable {
    func refreshControlValueChanged(_ control:UIRefreshControl)
    func didSelect(repository:Repository)
}


final class RepositoriesUIController : NSObject, RepositoriesFetchableDelegate {
    
    private let tableViewDataSource: TableViewDataSource<SimpleRepositoryCellController,SimpleRepositoryCell>
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        return control
    }()
    
    weak var delegate: RepositoriesUIControllerDelegate?
    
    var state: FetchingState<Array<Repository>> = .loading {
        willSet {
            update(with: newValue)
        }
    }

    init(tableView:UITableView) {
        self.tableViewDataSource = TableViewDataSource<SimpleRepositoryCellController,SimpleRepositoryCell>(tableView: tableView)
        super.init()
        tableView.refreshControl = refreshControl
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        update(with: state)
        
    }
    
    
    @objc func refreshControlValueChanged(_ control:UIRefreshControl){
        delegate?.refreshControlValueChanged(control)
    }
    
    
    func update(with newState: FetchingState<Array<Repository>>) {
        switch (state,newState) {
        case (_, .loading):
            refreshControl.beginRefreshing()
            break
        case (_,.success(let repos)):
            refreshControl.endRefreshing()
            tableViewDataSource.dataSource = repos.map{ SimpleRepositoryCellController.init($0) }
            break
        case (_,.failure(let error)):
            delegate?.shouldPresent(error: error)
            refreshControl.endRefreshing()
            break
        }
    }
}

extension RepositoriesUIController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .success(let repos):
            delegate?.didSelect(repository: repos[indexPath.row])
            break
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
