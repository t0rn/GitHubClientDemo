//
//  RepositoryHeaderViewUIController.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 18.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit


final class RepositoryHeaderViewUIController : ImageFetcherDelegate {
    
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    var repository: Repository? {
        didSet {
            updateLabels()
        }
    }
    
    let avatarImageView:UIImageView
    let mainLabel: UILabel
    let detailLabel: UILabel
    
    init(avatarImageView:UIImageView, mainLabel:UILabel, detailLabel:UILabel ) {
        self.avatarImageView = avatarImageView
        self.mainLabel = mainLabel
        self.detailLabel = detailLabel
        
        setupImageView()
        updateLabels()
    }
    
    func setupImageView() {
        avatarImageView.superview!.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height/2
        avatarImageView.layer.borderColor = UIColor.darkText.cgColor
        avatarImageView.layer.borderWidth = 0.5
    }
    
    func updateLabels() {
        mainLabel.text = repository?.fullname
        detailLabel.text = repository?.descr
    }
    
    //MARK: ImageFetcherDelegate
    
    var state: FetchingState<UIImage> = .loading {
        willSet {
            update(with: newValue)
        }
    }
    
    func update(with newState: FetchingState<UIImage>) {
        switch (state,newState) {
        case (.loading,.loading):
            spinner.startAnimating()
            break
        case (.loading, .failure(let error)):
            spinner.stopAnimating()
            //TODO: set an error image or smthg like that
            print(error)
            break
        case (.loading,.success(let image)):
            spinner.stopAnimating()
            self.avatarImageView.image = image
            break
        default:
            spinner.stopAnimating()
            break
        }
    }
    
}
