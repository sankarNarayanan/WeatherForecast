//
//  WFNextDayCell.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit

class WFNextDayCell: UITableViewCell {
    //MARK: Iboutlets
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var weatherMainLbl: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    
    //MARK: Model variable
    var dayModel:DayModel = DayModel()
    
    func setDataFromModel(currentDayModel : DayModel){
        self.dayModel = currentDayModel
        let date = currentDayModel.derivedDate ?? Date()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = String(hour) + ":" + String(minutes)
        self.timeLbl.text = time
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        self.dateLbl.text = result
        self.weatherDesc.text = currentDayModel.weather?.desc ?? ""
        self.weatherMainLbl.text = currentDayModel.weather?.main ?? ""
    }
    
    
}
