//
//  GithibAPIClientTests.swift
//  SimpleGithubClientTests
//
//  Created by Alexey Ivanov on 21.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import XCTest
@testable import SimpleGithubClient

class GithibAPIClientTests: XCTestCase {
    
    var client: FakeGitHubClient!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = FakeGitHubClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    ///Test that GithibAPIClient will return correct data from cache if no internet connection
    func testNoConnectionResponseThanGetFromCacheDataAreSame() {
        let urlCache = client.sessionConfig.urlCache!
        
        //clear cache
        urlCache.removeAllCachedResponses()
        //prepare mock objects
        let reposToCache = [ MockRepository.repository() ]
        //encode objects
        let json = try! JSONEncoder().encode(reposToCache)
        //prepare request to resource
        let request = GithubEndpoints.repositories(since: nil).request
        //response to save into cache
        let response = HTTPURLResponse(url: request.url!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)
        
        let cachedResponse = CachedURLResponse(response: response!, data: json)
        urlCache.storeCachedResponse(cachedResponse, for: request)
        
        //perform fake request with connection error ONCE
        let fakeTask = FakeSessionDataTask.fakeTaskWithNotConnectedToInternetError()
        client.fakeTasksQ.enqueue(fakeTask)
        
        let exp = expectation(description: "Repositories stored into cache should be same as retrieved by client")
        
        client.fetchRepositories { (result) in
            //response from cache with data should equals to cached data
            switch result {
            case .success(let repos):
                XCTAssertEqual(repos, reposToCache)
                exp.fulfill()
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        }
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}


///GithHubClient subclass for injecting "fake" session tasks for requests
class FakeGitHubClient : GithibAPIClient {
    
    var fakeTasksQ = Queue<FakeSessionDataTask>()
    private let realClient = GithibAPIClient()
    
    override func dataTask<T>(model: T.Type, request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask where T : Decodable, T : Encodable {
        
        guard let task = fakeTasksQ.dequeue() else {
            return realClient.dataTask(model: model, request: request, completion: completion)
        }
        task.completion = completion
        return task
    }
    
}

///URLSessionDataTask subclass for injecting result into completionHandler
class FakeSessionDataTask : URLSessionDataTask {
    
    var result:(Data?, URLResponse?, Error?)?
    var completion:((Data?, URLResponse?, Error?) -> Void)?
    
    override func resume() {
        completion?(result?.0,result?.1,result?.2)
        completion = nil
    }
    
    class func fakeTaskWithNotConnectedToInternetError() -> FakeSessionDataTask {
        let connectionError = NSError(domain: String(describing: self),
                                      code: NSURLErrorNotConnectedToInternet,
                                      userInfo: nil)
        let fakeTask = FakeSessionDataTask()
        fakeTask.result = (nil,nil,connectionError)
        return fakeTask
    }
}


