//
//  RepositoryHeaderViewController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 18.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

class RepositoryHeaderViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var headerUIController: RepositoryHeaderViewUIController!
    var imageFetcher: ImageFetcher!
    
    var repository: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerUIController = RepositoryHeaderViewUIController(avatarImageView: avatarImageView,
                                                              mainLabel: mainLabel,
                                                              detailLabel: detailLabel)
        headerUIController.repository = repository
        
        imageFetcher = ImageFetcher()
        imageFetcher.delegate = headerUIController
        
        imageFetcher.fetchImage(repository.owner.avatarURL)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}
