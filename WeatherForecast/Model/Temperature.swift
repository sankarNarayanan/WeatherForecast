//
//  Temperature.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class Temperature : NSObject {
    var temp : Float?
    var tempMin : Float?
    var tempMax : Float?
    var pressure : Float?
    var seaLevel: Float?
    var groundLevel : Float?
    var humidity : Float?
    
    init(responseDict: Dictionary<String,AnyObject>){
        self.temp = (responseDict["temp"] as? Float) ?? 0.0
        self.temp = (self.temp ?? 0) - 273.15
        self.tempMin = (responseDict["temp_min"] as? Float) ?? 0.0
        self.tempMin = (self.tempMin ?? 0) - 273.15
        self.tempMax = (responseDict["temp_max"] as? Float) ?? 0.0
        self.tempMax = (self.tempMax ?? 0) - 273.15
        self.pressure = (responseDict["pressure"] as? Float) ?? 0.0
        self.seaLevel = (responseDict["sea_level"] as? Float) ?? 0.0
        self.groundLevel = (responseDict["grnd_level"] as? Float) ?? 0.0
        self.humidity = (responseDict["humidity"] as? Float) ?? 0.0
        super.init()
    }
    
}
