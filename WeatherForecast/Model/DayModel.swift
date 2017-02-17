//
//  DayModel.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class DayModel : NSObject
{
    var tempertaure : Temperature?
    var weather : Waether?
    var wind : Wind?
    var date : Double?
    var derivedDate : Date?
    var country : String?
    var city : String?
    
    override init(){
        super.init()
    }
    
    func setUpData(temp : Temperature, weather : Waether, wind: Wind, date : Double, country : String, city : String) {
        self.tempertaure = temp
        self.weather = weather
        self.wind = wind
        self.date = date
        self.country = country
        self.city = city
    }
    
    func setDateObject(){
        let date = Date(timeIntervalSince1970: self.date ?? 0.0)
        self.derivedDate = date
    }
}
