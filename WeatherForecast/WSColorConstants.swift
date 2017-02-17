//
//  WSColorConstants.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit

struct WFColors{
    static let baseBlueColor = UIColor.colorWithHexValue(hexValue: "#3CAEDA")
}

struct tableViewColors {
    static let lightBlue = UIColor.colorWithHexValue(hexValue: "#03A9F4")
    static let teal = UIColor.colorWithHexValue(hexValue: "#009688")
    static let brown = UIColor.colorWithHexValue(hexValue: "#795548")
    static let purple = UIColor.colorWithHexValue(hexValue: "#9C27B0")
    static let indigo = UIColor.colorWithHexValue(hexValue: "#3F51B5")
}

extension UIColor {
    @objc class func colorWithHexValue(hexValue:NSString) -> UIColor {
        var c:UInt32 = 0xffffff
        if hexValue.hasPrefix("#") {
            Scanner(string: hexValue.substring(from: 1)).scanHexInt32(&c)
        }else{
            Scanner(string: hexValue as String).scanHexInt32(&c)
        }
        if hexValue.length > 7 {
            return UIColor(red: CGFloat((c & 0xff000000) >> 24)/255.0, green: CGFloat((c & 0xff0000) >> 16)/255.0, blue: CGFloat((c & 0xff00) >> 8)/255.0, alpha: CGFloat(c & 0xff)/255.0)
        }else{
            return UIColor(red: CGFloat((c & 0xff0000) >> 16)/255.0, green: CGFloat((c & 0xff00) >> 8)/255.0, blue: CGFloat(c & 0xff)/255.0, alpha: 1.0)
        }
    }
}
