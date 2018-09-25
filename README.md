# GitHubClientDemo
Demo project for using HTTP caching by URLSession and "modern" MVC pattern

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/9qHz258LhAA/0.jpg)](https://www.youtube.com/watch?v=9qHz258LhAA)


#### Changing cache policy for response with NSURLErrorNotConnectedToInternet error
```swift 

func fetch<T:APIModel>(model:T.Type, request: URLRequest,completion: @escaping (Result<[T]>) -> Void) {
    let task = dataTask(model: model, request: request) { (data, response, error) in
        //here we check that if we don't have connection,
        //then try to use cache
        if let error = error as NSError?,
            error.code == NSURLErrorNotConnectedToInternet {
            //copy request and change cache policy
            var req = request
            req.cachePolicy = .returnCacheDataDontLoad
            self.fetch(model: model, request: req, completion: completion)
            return
        }
       ...
    }
    task.resume()
}
