

/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Shows how to lift operation-like objects in to the NSOperation world.
 */

import Foundation

private var URLSessionTaksOperationKVOContext = 0

/**
 `URLSessionTaskOperation` is an `Operation` that lifts an `NSURLSessionTask`
 into an operation.
 
 Note that this operation does not participate in any of the delegate callbacks \
 of an `NSURLSession`, but instead uses Key-Value-Observing to know when the
 task has been completed. It also does not get notified about any errors that
 occurred during execution of the task.
 
 An example usage of `URLSessionTaskOperation` can be seen in the `DownloadEarthquakesOperation`.
 */

typealias URLSessionTaskOperationCompletionHandler = (_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void?

class URLSessionTaskOperation: AppOperation {
    var task: URLSessionTask?
    var callBack: URLSessionTaskOperationCompletionHandler?
    var request:NSURLRequest?
    
    init(requestObject:NSURLRequest,completion:@escaping (_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void ) {
        super.init()
        callBack = completion
        request = requestObject
        //assert(task.state == .Suspended, "Tasks must be suspended.")
        setupTask()
    }
    
    func setupTask(){
        if let request = self.request {
            self.task = URLSession.shared.dataTask(with: request as URLRequest) {[weak self] data, response, error in
                if self!.callBack != nil{
                    self!.callBack?(data as AnyObject?, response, error as AnyObject?)
                }
                self!.finish()
            }
        }
    }
    
    override func execute() {
        assert(task!.state == .suspended, "Task was resumed by something other than \(self).")
        
        //task.addObserver(self, forKeyPath: "state", options: [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New], context: &URLSessionTaksOperationKVOContext)
        
        task?.resume()
    }
    
    /*override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
     guard context == &URLSessionTaksOperationKVOContext else { return }
     
     if object === task && keyPath == "state" && task.state == .Completed && (task.response != nil || task.error != nil) {
     task.removeObserver(self, forKeyPath: "state")
     finish()
     }
     }*/
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
}

