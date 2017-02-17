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
    var date : String?
    var derivedDate : NSDate?
    
    init(temp : Temperature, weather : Waether, wind: Wind, date : String) {
        self.tempertaure = temp
        self.weather = weather
        self.wind = wind
        self.date = date
        super.init()
    }
    
    func getDateObject() -> NSDate{
        return NSDate(timeIntervalSince1970: Double(self.date ?? "") ?? 0)
    }
}
