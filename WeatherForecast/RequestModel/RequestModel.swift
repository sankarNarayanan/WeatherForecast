//
//  RequestModel.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 20/01/16.
//  Copyright © 2016 Sankar Narayanan. All rights reserved.
//

import Foundation


class RequestModel: NSObject{
    
    var url : String?
    
    var requestHeaders : Dictionary<String,String>?
    
    var postBodyDictionary : Dictionary<String,AnyObject>?
    
    var requestType : String = "POST"
    
    var requestTimeout : Double?
    
    var appVersion : String?
    
    var product : String?
    
    var postData : NSData?
    
    var jsonParsingRequired : Bool = true
    
    init(url:String?, requestHeaders : Dictionary<String,String>?, postBody : Dictionary<String,AnyObject>?, requestType : String?, timeout: Double?, appVersion : String?, postData : NSData?){
        self.url = url
        self.requestHeaders = requestHeaders
        self.postBodyDictionary = postBody
        self.requestType = requestType!
        self.requestTimeout = timeout
        self.appVersion = appVersion
        self.postData = postData
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    
    
}
