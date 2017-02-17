

//
//  NetworkOperation.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 20/01/16.
//  Copyright © 2016 Sankar Narayanan. All rights reserved.
//

import Foundation

class NetworkOperation: GroupOperation {
    // MARK: Initialization
    
    var localRequestOject : NSMutableURLRequest?
    
    var callBack : (_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void?
    
    var requestOperation : RequestOperation?
    
    var url : NSURL?
    
    var responseData:NSData?
    
    var error:NSError?
    
    var responseHeaders : AnyObject?
    
    /// - parameter cacheFile: The file `NSURL` to which the earthquake feed will be downloaded.
    init(withRequestOperation: RequestOperation, requestUrl : NSURL, connectionCallBack:@escaping (_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void) {
        self.requestOperation = withRequestOperation
        self.callBack = connectionCallBack
        self.url = requestUrl
        super.init(operations: [])
    }
    
    
    override func execute() {
        self.localRequestOject = self.requestOperation?.requestObject
        //self.requestOperation = nil
        self.url = localRequestOject?.url as NSURL?
        
        let taskOperation = URLSessionTaskOperation(requestObject: self.localRequestOject!) { [weak self](response, responseHeaders, error) in
            if self != nil{
                self!.responseData = response as? NSData
                self!.responseHeaders = responseHeaders
                self!.error = error as? NSError
                self!.finish()
            }
            
        }
        let reachabilityCondition = ReachabilityCondition(host: self.url!)
        taskOperation.addCondition(condition: reachabilityCondition)
        addOperation(operation: taskOperation)
        super.execute()
    }
    
    deinit{
        //print("NetworkOperation flushed out!!")
    }
}

