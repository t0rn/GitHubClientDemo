//
//  DetailViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    //TODO: use caseiterable in swift 4.2!
    enum RepositoryInfos : String {
        case forks
        case subscribers
        case stargazers
    }
    
    
    var repository: Repository?
    
    
    @IBOutlet weak var stargazersLabelView: LabelView!
    @IBOutlet weak var subscribersLabelView: LabelView!
    @IBOutlet weak var forksLabelView: LabelView!
    
    var stargazersFetcher: CountFetcher<User>!
    var forksFetcher: CountFetcher<Repository>!
    var subscribersFetcher: CountFetcher<User>!
    
    var forksVC: LabelViewController!
    var subscribersVC: LabelViewController!
    var stargazersVC: LabelViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        guard let repository = repository else {return}
        
        setupViewControllers()
        setupFetchers(for: repository)
    }
    

    
    func setupFetchers(for repo:Repository) {
        //can't use abstract method cause can't use CountFetcher without generic parameter
        //or use type erasure pattern
        stargazersFetcher = CountFetcher<User>(apiClient: GithibAPIClient())
        stargazersFetcher.delegate = stargazersVC
        stargazersFetcher.fetchCount(from: GithubEndpoints.stargazers(repo))
        
        forksFetcher = CountFetcher<Repository>(apiClient: GithibAPIClient())
        forksFetcher.delegate = forksVC
        forksFetcher.fetchCount(from: GithubEndpoints.forks(repo))
        
        subscribersFetcher = CountFetcher<User>(apiClient: GithibAPIClient())
        subscribersFetcher.delegate = subscribersVC
        subscribersFetcher.fetchCount(from: GithubEndpoints.subscribers(repo))
    }
    
    
    
    func setupViewControllers(for cases:[RepositoryInfos] = [RepositoryInfos.stargazers,RepositoryInfos.subscribers,RepositoryInfos.forks]) {
        let vcs = cases.map { LabelViewController(labelView: labelView(by: $0), title: $0.rawValue.capitalized) }
        zip(cases, vcs).forEach { (info,vc) in
            switch info {
            case .forks:
                forksVC = vc
                break
            case .stargazers:
                stargazersVC = vc
                break
            case .subscribers:
                subscribersVC = vc
                break
            }
        }
    }
    
    
    func labelView(by info:RepositoryInfos) -> LabelView {
        switch info {
        case .forks:
            return forksLabelView
        case .stargazers:
            return stargazersLabelView
        case .subscribers:
            return subscribersLabelView
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    
    // MARK: - Navigation
    //TODO: use coordinator pattern
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRepoHeaderViewController",
            let vc = segue.destination as? RepositoryHeaderViewController {
            vc.repository = self.repository
        }
    }
 

}
