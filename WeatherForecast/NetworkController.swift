//
//  NetworkController.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 24/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func makeWebServiceCall(requestModel:RequestModel, callback : @escaping (_ response: AnyObject?, _ error: NSError?) -> Void){
        var request : URLRequest?
        switch requestModel.requestType {
        case AppConstants.httpPostMethod:
            //Not handled right now.
            break
        case AppConstants.httpGetMethod:
            if let url = URL(string: (requestModel.url ?? "")){
                request = URLRequest(url: url)
            }
            break
        default:
            break
        }
        let task = URLSession.shared.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
            guard data != nil else {
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
                callback(parsedData as AnyObject?, error as NSError?)
            }
            catch _ {
                callback(data as NSData?, error as NSError?)
            }
        })
        task.resume()
    }
}
