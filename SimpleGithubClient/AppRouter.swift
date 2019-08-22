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
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self) { (s) -> Subscription<RoutingState> in
            s.select({ (state) -> RoutingState in
                state.routingState
            })
        }
        
    }
    
    
    fileprivate func pushViewController(identifier: String, animated: Bool) {
        let viewController = instantiateViewController(identifier: identifier)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    //MARK: - StoreSubscriber
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState.rawValue, animated: shouldAnimate)
    }
    
}
