//
//  Weather.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class Waether : NSObject
{
    var main : String?
    var desc : String?
    
    init(responseDict: Dictionary<String,AnyObject>){
        self.main = (responseDict["main"] as? String) ?? ""
        self.desc = (responseDict["description"] as? String) ?? ""
        super.init()
    }
    
}
