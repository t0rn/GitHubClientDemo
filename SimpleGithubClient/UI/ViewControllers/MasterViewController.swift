//
//  ViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit
import ReSwift

class MasterViewController: UIViewController  {
    
    private let tableView = UITableView(frame: .zero)
    
    var uiController: RepositoriesUIController!
    var fetcher: RepositoriesFetcher!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { (subscription) -> Subscription<ReposListState> in
            subscription.select({ (state) -> ReposListState in
                state.reposListState
            })
        }
        
        store.dispatch(RoutingAction(destination: .reposList))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        
        uiController = RepositoriesUIController(tableView: tableView)
        uiController.delegate = self
        
        fetcher = RepositoriesFetcher(apiClient: GithibAPIClient())
        fetcher.delegate = uiController
        
        fetcher.fetchRepositories()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navigation
    //TODO: use coordinator pattern
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
            let detailVC = segue.destination as? DetailViewController,
            let repo = sender as? Repository {
            detailVC.repository = repo
            return
        }
    }
}
extension MasterViewController : StoreSubscriber {
    typealias StoreSubscriberStateType = ReposListState
    
    func newState(state: ReposListState) {
        //TODO: inject new table data source
        
    }
}
extension MasterViewController : RepositoriesUIControllerDelegate {
    
    func shouldPresent(error: Error) {
        let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        present(alert, animated: true, completion: nil)
    }
    
    func refreshControlValueChanged(_ control: UIRefreshControl) {
        fetcher.fetchRepositories()
    }
    
    func didSelect(repository: Repository) {
        //TODO: pass repository
        store.dispatch(RoutingAction(destination: .repoDetails) )
    }

}

