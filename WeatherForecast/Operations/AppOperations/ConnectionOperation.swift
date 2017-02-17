

//
//  ConnectionOperation.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 21/01/16.
//  Copyright © 2016 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit

class ConnectionOperation : GroupOperation{
    
    var networkOperation: NetworkOperation?
    
    var requestOperation: RequestOperation?
    
    var parseOperation : ParseOperation?
    
    var completionHandler : ((_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void)
    
    init(withRequestObject : RequestModel, andCompletionHandler : @escaping (_ response: AnyObject?, _ responseHeaders: AnyObject?, _ error: AnyObject?) -> Void){
        
        //Initialize request Operation
        requestOperation = RequestOperation(requestModel: withRequestObject)
        
        //Initialize network operation
        networkOperation = NetworkOperation(withRequestOperation: requestOperation!, requestUrl: NSURL(string: withRequestObject.url!)!, connectionCallBack: andCompletionHandler)
        networkOperation!.requestOperation = requestOperation
        
        //Initialize parse operation
        parseOperation = ParseOperation(completedNetworkOperation: networkOperation!)
        
        if(!(withRequestObject.jsonParsingRequired)){
            parseOperation!.jsonParsingRequired = false
        }
        
        networkOperation!.addDependency(requestOperation!)
        
        parseOperation!.addDependency(networkOperation!)
        
        completionHandler = andCompletionHandler
        
        super.init(operations: [requestOperation!,networkOperation!,parseOperation!])
    }
    
    
    override func operationDidFinish(operation: Operation, withErrors errors: [NSError]) {
        if let firstError = errors.first , (operation === networkOperation || operation === requestOperation) {
            self.completionHandler(nil, nil, firstError)
        }
    }
    
    deinit{
        //print("ConnectionOperation flushed out!!")
    }
}

