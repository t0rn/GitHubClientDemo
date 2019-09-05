//
//  AppRouter.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 22/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

enum RoutingDestination: String {
    case reposList = "MasterViewController"
    case repoDetails = "DetailViewController"
}


final class AppRouter : StoreSubscriber {
    typealias StoreSubscriberStateType = RoutingState

    let navigationController: UINavigationController
    
    init(window: UIWindow,
         navigationController:UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        window.rootViewController = navigationController
        
        store.subscribe(self) { (subscription) -> Subscription<RoutingState> in
            subscription.select({ (state) -> RoutingState in
                state.routingState
            })
        }        
    }
    
    fileprivate func pushViewController(identifier: String, animated: Bool) {
        let viewController = instantiateViewController(identifier: identifier)
        push(viewController: viewController, animated: animated)
    }
    
    fileprivate func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    fileprivate func push(viewController:UIViewController, animated:Bool) {
        let newViewControllerType = type(of: viewController)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return
            }
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    //MARK: - StoreSubscriber
    func newState(state: RoutingState) {
        guard state.navigationState != .reposList else {
            push(viewController: MasterViewController(), animated: false)
            return
        }
        pushViewController(identifier: state.navigationState.rawValue, animated: true)
    }
    
}
