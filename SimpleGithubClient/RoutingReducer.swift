//
//  RoutingReducer.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 22/08/2019.
//  Copyright © 2019 Alexey Ivanov. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    switch action {
    case let routingAction as RoutingAction:
        state.navigationState = routingAction.destination
    default:break
    }
    return state
}
