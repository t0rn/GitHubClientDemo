//
//  MasterViewControllerTests.swift
//  SimpleGithubClientTests
//
//  Created by Alexey Ivanov on 20.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import XCTest
@testable import SimpleGithubClient

class MasterViewControllerTests: XCTestCase {
    
    var masterVC: MasterViewController!
    
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        masterVC = nc.viewControllers.first as! MasterViewController
        _ = masterVC.view // to call ViewDidLoad
    }
    
    //test that viewDidLoad in MasterViewController initialized uiController and RepositoriesFetcher
    //or it would crash at runtime
    func testViewDidLoad(){
        XCTAssertNotNil(masterVC.fetcher)
        XCTAssertNotNil(masterVC.uiController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
