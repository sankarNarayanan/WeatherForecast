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
    var speed : Float?
    var degree : Float?
    
    init(responseDict: Dictionary<String,AnyObject>){
        self.speed = (responseDict["speed"] as? Float) ?? 0.0
        self.degree = (responseDict["deg"] as? Float) ?? 0.0
        super.init()
    }
}
