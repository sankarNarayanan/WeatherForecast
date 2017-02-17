//
//  RequestOperation.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 20/01/16.
//  Copyright © 2016 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit

class RequestOperation: GroupOperation {
    // MARK: Initialization
    
    var requestObject : NSMutableURLRequest?
    
    let clientRequestObject : RequestModel?
    
    var baseUrlString : String?
    
    /// - parameter cacheFile: The file `NSURL` to which the earthquake feed will be downloaded.
    init(requestModel : RequestModel){
        self.clientRequestObject = requestModel
        super.init(operations: [])
    }
    
    override func execute() {
        
        //construct URL
        
        var finalUrl :String = ""
        
        finalUrl = AppConstants.urlString
        
        self.clientRequestObject!.url = finalUrl
        
        //construct request object
        
        self.requestObject = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: self.clientRequestObject!.requestTimeout ?? 60)
        requestObject?.httpMethod = self.clientRequestObject!.requestType 
        
        //Add generic headers here
        
        self.requestObject?.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        self.requestObject?.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: "iosversion")
        self.requestObject?.setValue("IOS", forHTTPHeaderField: "type")
        self.requestObject?.setValue(self.clientRequestObject!.appVersion, forHTTPHeaderField: "appversion")
        self.requestObject?.setValue(self.clientRequestObject!.product, forHTTPHeaderField: "product")

        //To add request Data
        
        if (self.clientRequestObject!.postBodyDictionary != nil){
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self.clientRequestObject!.postBodyDictionary!, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                let postData = jsonString.data(using: String.Encoding.utf8)
                self.requestObject?.httpBody = postData
                
            } catch let error as NSError {
                print(error)
            }
        }
        
        if (self.clientRequestObject!.postData != nil){
            self.requestObject?.httpBody = self.clientRequestObject!.postData! as Data
        }
        
        //To add cookies
        if (self.clientRequestObject!.requestHeaders != nil){
            for (key,value) in self.clientRequestObject!.requestHeaders!{
                self.requestObject?.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        finish()
    }
    
}
