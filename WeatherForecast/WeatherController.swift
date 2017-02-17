//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 16/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    
    //MARK: iboutlets
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var optimalTempLbl: UILabel!
    @IBOutlet weak var tempMinMaxLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var seaLevelLbl: UILabel!
    @IBOutlet weak var groundLevelLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var nextDaysTableView: UITableView!
    
    
    //MARK: View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

