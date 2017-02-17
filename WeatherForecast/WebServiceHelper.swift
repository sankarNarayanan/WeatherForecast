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
    static func getWetherData(completionHandler : @escaping (_ response: [DayModel]?) -> Void){
        //        let requestModel = RequestModel()
        //        requestModel.url = AppConstants.urlString
        //        requestModel.requestType = "GET"
        //        let connectionOperation = ConnectionOperation(withRequestObject: requestModel, andCompletionHandler:{(response: AnyObject?, responseHeaders: AnyObject?, error: AnyObject?) -> Void in
        //            if let responseDict = response as? NSDictionary{
        //                print(responseDict)
        //            }
        //        })
        //        let operationQueue = AppOperationQueue()
        //        //operationQueue.addOperation(connectionOperation)
        //        // Do any additional setup after loading the view, typically from a nib.
        if let responseDict = self.readJsonFile(fileName: "response") as? Dictionary<String,AnyObject>{
            print(responseDict)
            var dayModelArray : [DayModel] = [DayModel]()
            if let listArray = responseDict["list"] as? [Dictionary<String,AnyObject>]{
                for item in listArray{
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
                    dayModel.setDateObject()
                    
                    if (dayModelArray.count == 0){
                        dayModelArray.append(dayModel)
                    }else{
                        let count = dayModelArray.count
                        let dayModelInArray = dayModelArray[count-1]
                        let differenceInHours = dayModel.derivedDate?.hours(from: dayModelInArray.derivedDate ?? Date())
                        if (differenceInHours == 24){
                            dayModelArray.append(dayModel)
                        }
                    }
                }
            }
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.weatherForecastArray = dayModelArray
            completionHandler(dayModelArray)
        }
    }
    
    static func readJsonFile(fileName: String) -> NSDictionary{
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
