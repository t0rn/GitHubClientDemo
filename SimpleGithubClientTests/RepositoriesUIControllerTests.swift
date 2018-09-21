//
//  RepositoriesUIControllerTests.swift
//  SimpleGithubClientTests
//
//  Created by Alexey Ivanov on 20.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import XCTest
@testable import SimpleGithubClient


class RepositoriesUIControllerTests: XCTestCase {
    var repositoriesUIController: RepositoriesUIController!
    let tableView = UITableView(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        
        repositoriesUIController =  RepositoriesUIController(tableView: tableView)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingToFailureState() {
        let fakeDelegate = FakeRepositoriesFetchableDelegate(delegate: repositoriesUIController)
        fakeDelegate.delegate(.loading)
        XCTAssertEqual(repositoriesUIController.state, .loading)
        
        let error = APIErrors.wrongResponseCode(213)
        fakeDelegate.delegate(.failure(error))
        XCTAssertEqual(repositoriesUIController.state, FetchingState<[Repository]>.failure(error))
    }
    
    func testLoadingToSuccessState() {
        let fakeDelegate = FakeRepositoriesFetchableDelegate(delegate: repositoriesUIController)
        fakeDelegate.delegate(.loading)
        XCTAssertEqual(repositoriesUIController.state, .loading)
        
        //TODO: add mocked objects
        let state = FetchingState<[Repository]>.success([])
        fakeDelegate.delegate(state)
        XCTAssertEqual(repositoriesUIController.state, state)
    }
    
    func testLoadingToLoadingState() {
        let state = FetchingState<[Repository]>.loading
        let fakeDelegate = FakeRepositoriesFetchableDelegate(delegate: repositoriesUIController)
        fakeDelegate.delegate(state)
        XCTAssertEqual(repositoriesUIController.state, state)
        
        fakeDelegate.delegate(state)
        XCTAssertEqual(repositoriesUIController.state, state)
    }
    
    func testSuccessToFailureState() {
        
        let state1:FetchingState<[Repository]> = .success([])
        let fakeDelegate = FakeRepositoriesFetchableDelegate(delegate: repositoriesUIController)
        
        repositoriesUIController.state = state1
        fakeDelegate.delegate?.state = state1
        
        XCTAssertEqual(repositoriesUIController.state, state1)
        
        let error = APIErrors.wrongResponseCode(213)
        let state2: FetchingState<[Repository]> = .failure(error)
        fakeDelegate.delegate?.state = state2
        
        XCTAssertEqual(repositoriesUIController.state, state2)
    }
    
}


class FakeRepositoriesFetchableDelegate {
    weak var delegate: RepositoriesFetchableDelegate?
    
    init(delegate: RepositoriesFetchableDelegate? ){
        self.delegate = delegate
    }
    func delegate(_ state: FetchingState<Array<Repository>> ) {
        delegate?.state = state
    }
}

