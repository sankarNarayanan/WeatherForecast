//
//  WFWebserviceHelperTester.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 24/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WFWebserviceHelperTester: XCTestCase {
    //Test model creation
    func testDayModelCreation(){
        let fileName = "DayModel"
        let webServiceHelper = WebServiceHelper()
        let dict = webServiceHelper.readJsonFile(fileName: fileName) as! Dictionary<String,AnyObject>
        let dayModel : DayModel = webServiceHelper.getDayModel(item: dict, city: "chennai", country: "IN")
        XCTAssertEqual([dayModel.city ?? "", dayModel.country ?? ""], ["chennai", "IN"], "Day model variables compared")
    }
    
    //Test web service calls
    func testWebserviceResponse(){
        let webServiceHelper:WebServiceHelper = WebServiceHelper()
        webServiceHelper.getWetherData(completionHandler: {(response: [DayModel]?) -> Void in
            XCTAssertNotNil(response)
        })
    }
    
    func testColorExtensionWithValidValue(){
        let baseBlueColor = UIColor.colorWithHexValue(hexValue: "#3CAEDA")
        XCTAssertNotNil(baseBlueColor)
    }
    
    func testColorExtensionWithInvalidValue(){
        let baseBlueColor = UIColor.colorWithHexValue(hexValue: "#")
        XCTAssertNotNil(baseBlueColor)
    }
    
    func testDateExtension(){
        let date = Date()
        let years = date.years(from: Date())
        XCTAssertEqual(0, years, "comparing years")
    }
    
    
    
}
