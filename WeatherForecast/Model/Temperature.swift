//
//  Temperature.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class Temperature : NSObject {
    var temp : String?
    var tempMin : String?
    var tempMax : String?
    var pressure : String?
    var seaLevel: String?
    var groundLevel : String?
    var humidity : String?
    
    init(responseDict: Dictionary<String,AnyObject>){
        self.temp = (responseDict["temp"] as? String) ?? ""
        self.tempMin = (responseDict["temp_min"] as? String) ?? ""
        self.tempMax = (responseDict["temp_max"] as? String) ?? ""
        self.pressure = (responseDict["pressure"] as? String) ?? ""
        self.seaLevel = (responseDict["sea_level"] as? String) ?? ""
        self.groundLevel = (responseDict["grnd_level"] as? String) ?? ""
        self.humidity = (responseDict["humidity"] as? String) ?? ""
        super.init()
    }
    
}
