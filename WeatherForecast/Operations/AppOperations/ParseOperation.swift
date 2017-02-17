//
//  ParseOperation.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 21/01/16.
//  Copyright © 2016 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit


class ParseOperation: GroupOperation {
    
    var networkOperation : NetworkOperation?
    
    var data : NSData?
    
    var jsonParsingRequired : Bool = true
    
    // MARK: Initialization
    init(completedNetworkOperation : NetworkOperation){
        self.networkOperation = completedNetworkOperation
        super.init(operations: [])
    }
    
    override func execute() {
        
        var parsedData:Any?
        
        self.data = self.networkOperation?.responseData
        
        guard let parseData = self.data else {
            #if DEBUG
                self.networkOperation?.callBack(self.networkOperation?.responseData, self.networkOperation?.responseHeaders, self.networkOperation?.error)
            #else
                let localError = NSError(domain: "Something went wrong.", code: 0, userInfo: nil)
                self.networkOperation?.callBack(nil, nil, localError)
            #endif
            finish()
            return
        }
        do {
            if (self.jsonParsingRequired){
                parsedData = try JSONSerialization.jsonObject(with: parseData as Data, options: .allowFragments)
                (self.networkOperation?.callBack(parsedData as AnyObject?, self.networkOperation?.responseHeaders, self.networkOperation?.error))!
                finish()
                
            }else{
                self.networkOperation?.callBack(parseData, self.networkOperation?.responseHeaders, self.networkOperation?.error)
                finish()
            }
        }
        catch _ {
            var localError : NSError?
            if (self.networkOperation?.error == nil)
            {
                #if DEBUG
                    print("Response Parsing error")
                    if self.data != nil{
                        print("Response from service: \(NSString(data: self.data! as Data, encoding: String.Encoding.utf8.rawValue)))")
                    }
                #endif
                
            }else{
                #if DEBUG
                    print(self.networkOperation?.error ?? "")
                #endif
                //                localError = self.networkOperation?.error
            }
            localError = NSError(domain: "Something went wrong.", code: 0, userInfo: nil)
            self.networkOperation?.callBack(nil, nil, localError)
            finish()
            return
        }
    }
    
}
