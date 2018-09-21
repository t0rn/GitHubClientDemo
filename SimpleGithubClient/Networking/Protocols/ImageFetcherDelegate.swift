//
//  ImageFetcherDelegate.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit

protocol ImageFetcherDelegate : class {
    var state: FetchingState<UIImage> {get set}
}
