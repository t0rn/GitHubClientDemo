//
//  ViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit
import ReSwift

class MasterViewController: BaseTableViewController  {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { (subscription) -> Subscription<ReposListState> in
            subscription.select({ (state) -> ReposListState in
                state.reposListState
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fetch()
    }

    override func refreshControlValueChanged() {
        fetch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func fetch() {
        store.dispatch(fetchReposAction())
    }
    
}

extension MasterViewController : StoreSubscriber {
    typealias StoreSubscriberStateType = ReposListState
    
    func newState(state: ReposListState) {
        //TODO: inject new table data source
        if let repos = state.repos {
            print(repos)
        }
        //TODO: toggle loading activity indicator by state.showLoading
        
    }
}
extension MasterViewController  {
    
    func presentAlertFor(error: Error) {
        let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        present(alert, animated: true, completion: nil)
    }
    
    func didSelect(repository: Repository) {
        //TODO: pass repository
        store.dispatch( RoutingAction(destination: .repoDetails) )
    }

}

