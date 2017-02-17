//
//  Wind.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class Wind : NSObject
{
    var speed : String = ""
    var degree : String = ""
    
    init(responseDict: Dictionary<String,AnyObject>){
        self.speed = (responseDict["speed"] as? String) ?? ""
        self.degree = (responseDict["deg"] as? String) ?? ""
        super.init()
    }
}
