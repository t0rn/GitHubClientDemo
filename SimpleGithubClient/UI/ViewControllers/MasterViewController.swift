//
//  ViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit


class MasterViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero)
    
    var uiController: RepositoriesUIController!
    var fetcher: RepositoriesFetcher!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
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
        performSegue(withIdentifier: "toDetailVC", sender: repository)
    }

}

