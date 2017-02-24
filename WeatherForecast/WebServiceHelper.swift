//
//  WebServiceHelper.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit

class WebServiceHelper {
    
    var dayModelArray : [DayModel] = [DayModel]()
    
    
    //MARK: Webservice Call Methods
    func getWetherData(completionHandler : @escaping (_ response: [DayModel]?) -> Void){
        let requestModel = RequestModel()
        requestModel.url = AppConstants.urlString
        requestModel.requestType = "GET"
        NetworkController.makeWebServiceCall(requestModel: requestModel, callback: {(response : AnyObject?, error : NSError?) -> Void in
            if let responseDict = response as? NSDictionary{
                var city = "", country = ""
                if let cityNode = responseDict["city"] as? Dictionary<String,AnyObject>{
                    city = cityNode["name"] as? String ?? ""
                    country = cityNode["country"] as? String ?? ""
                }
                if let listArray = responseDict["list"] as? [Dictionary<String,AnyObject>]{
                    for item in listArray{
                        let dayModel = self.getDayModel(item: item, city: city, country: country)
                        self.addEntryToArray(dayModel: dayModel)
                    }
                }
                completionHandler(self.dayModelArray)
            }
        })
    }
    
    
    
    //MARK: Parse Utilities
    func getDayModel(item : Dictionary<String,AnyObject>, city: String, country: String) -> DayModel{
        let dayModel = DayModel()
        if let temperatureDict = item["main"] as? Dictionary<String,AnyObject>{
            let tempModel = Temperature(responseDict: temperatureDict)
            dayModel.tempertaure = tempModel
        }
        if let weatherArray = item["weather"] as? [Dictionary<String,AnyObject>]{
            for item in weatherArray{
                let weatherModel = Waether(responseDict: item)
                dayModel.weather = weatherModel
            }
        }
        if let windDict = item["wind"] as? Dictionary<String,AnyObject>{
            let windModel = Wind(responseDict: windDict)
            dayModel.wind = windModel
        }
        dayModel.date = (item["dt"] as? Double) ?? 0.0
        dayModel.city = city
        dayModel.country = country
        dayModel.setDateObject()
        return dayModel
    }
    
    func addEntryToArray(dayModel : DayModel){
        if (self.dayModelArray.count == 0){
            self.dayModelArray.append(dayModel)
        }else{
            let count = self.dayModelArray.count
            let dayModelInArray = self.dayModelArray[count-1]
            let differenceInHours = dayModel.derivedDate?.hours(from: dayModelInArray.derivedDate ?? Date())
            if (differenceInHours == 24){
                self.dayModelArray.append(dayModel)
            }
        }
    }
    
    
    //MARK: Sample response from bundle
    func readJsonFile(fileName: String) -> NSDictionary{
        var jsonResult:NSDictionary = NSDictionary()
        do {
            let path = Bundle.main.path(forResource: fileName, ofType: "json")
            let data = try NSData(contentsOfFile: (path)!, options: NSData.ReadingOptions.uncached)
            
            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        }catch _{
            
        }
        return jsonResult
    }
    
}
