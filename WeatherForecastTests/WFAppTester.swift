//
//  WFAppTester.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 20/03/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//


import XCTest
@testable import WeatherForecast

class WFAppTester: XCTestCase {
    
    //MARK: Test web service calls
    func testWebserviceResponse(){
        let webServiceHelper:WebServiceHelper = WebServiceHelper()
        webServiceHelper.getWetherData(completionHandler: {(response: [DayModel]?) -> Void in
            XCTAssertGreaterThan((response?.count ?? 0), 0)
        })
    }
    
    //MARK: Test model creation
    func testDayModelCreation(){
        let fileName = "DayModel"
        let webServiceHelper = WebServiceHelper()
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as! Dictionary<String,AnyObject>
        let dayModel : DayModel = webServiceHelper.getDayModel(item: dict, city: "chennai", country: "IN")
        XCTAssertEqual([dayModel.city ?? "", dayModel.country ?? ""], ["chennai", "IN"], "Day model variables compared")
    }
    
    func testTemperatureModelCreation(){
        let fileName = "Temperature"
        let webServiceHelper = WebServiceHelper()
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as! Dictionary<String,AnyObject>
        let tempModel = Temperature(responseDict: dict)
        XCTAssertEqual(tempModel.tempMin, 26.3399963, "Tempertaure comparison")
    }
    
    func testWeatherModelCreation(){
        let fileName = "Weather"
        let webServiceHelper = WebServiceHelper()
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as! Dictionary<String,AnyObject>
        let weatherModel = Waether(responseDict: dict)
        XCTAssertEqual((weatherModel.desc ?? ""), "clear sky", "Weather comparison")
    }
    
    func testWindModelCreation(){
        let fileName = "Wind"
        let webServiceHelper = WebServiceHelper()
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as! Dictionary<String,AnyObject>
        let windModel = Wind(responseDict: dict)
        XCTAssertEqual((windModel.degree ?? 0), 62.0009, "Wind comparison")
    }
    
    //MARK: Test extensions
    func testColorExtensionWithValidValue(){
        let baseBlueColor = UIColor.colorWithHexValue(hexValue: "#3CAEDA")
        XCTAssertNotNil(baseBlueColor)
    }
    
    func testColorExtensionWithInvalidValue(){
        let baseBlueColor = UIColor.colorWithHexValue(hexValue: "#")
        let c:UInt32 = 0xffffff
        XCTAssertEqual(baseBlueColor, UIColor(red: CGFloat((c & 0xff0000) >> 16)/255.0, green: CGFloat((c & 0xff00) >> 8)/255.0, blue: CGFloat(c & 0xff)/255.0, alpha: 1.0), "Color comparison")
    }
    
    func testDateExtension(){
        let date = Date()
        let years = date.years(from: Date())
        XCTAssertEqual(0, years, "comparing years")
    }
    
    //MARK: Test Sample response file reading
    func testReadSampleResponseWithInValidFileName(){
        let webServiceHelper = WebServiceHelper()
        let fileName = "Day"
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as? Dictionary<String,AnyObject>
        XCTAssertEqual((dict?.keys.count ?? 0), 0, "File readind error scenario")
    }
    
    func testReadSampleResponseWithValidFileName(){
        let webServiceHelper = WebServiceHelper()
        let fileName = "DayModel"
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as? Dictionary<String,AnyObject>
        XCTAssertGreaterThan(dict?.keys.count ?? 0, 0)
    }
    
}
