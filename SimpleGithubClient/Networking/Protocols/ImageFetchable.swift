//
//  ImageFetchable.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 19.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import Foundation

protocol ImageFetchable {
    func fetchImage(_ url:URL, cachePolicy:URLRequest.CachePolicy)
    var delegate: ImageFetcherDelegate? {get set}
}
