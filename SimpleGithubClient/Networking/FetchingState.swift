//
//  FetchingState.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation


enum FetchingState<T:Equatable> {
    case loading
    case success(T)
    case failure(Error)
}



extension FetchingState : Equatable {
    static func == (lhs: FetchingState<T>, rhs: FetchingState<T>) -> Bool {
        switch (lhs,rhs) {
        case (.loading,.loading):
            return true
        case (.failure(let err1), .failure(let err2)):
            
            //TODO: don't use localizedDescription for comparing errors
            return err1.localizedDescription == err2.localizedDescription
        case (.success(let repos1),.success(let repos2)):
            return repos1 == repos2
            
        case (.success(_), .loading),
             (.success(_), .failure(_)),
             (.failure(_), .loading),
             (.failure(_), .success(_)),
             (.loading, .success(_)),
             (.loading, .failure(_)):
            
            return false
        }
    }
}

