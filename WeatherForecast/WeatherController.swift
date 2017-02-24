//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 16/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import UIKit

class WeatherController: WFBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: class level variables
    var weatherDayArray : [DayModel] = [DayModel]()
    
    
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
    @IBOutlet weak var weatherPrediction: UILabel!
    
    
    //MARK: View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityView()
        let webServiceHelper:WebServiceHelper = WebServiceHelper()
        webServiceHelper.getWetherData(completionHandler: {(response: [DayModel]?) -> Void in
            DispatchQueue.main.async  {
                self.weatherDayArray = response ?? [DayModel]()
                self.nextDaysTableView.reloadData()
                if (self.weatherDayArray.count > 0){
                    self.setUpViewData(currentDayModel: self.weatherDayArray[0])
                }
                self.hideActivityView()
            }
        })
        if (self.weatherDayArray.count > 0){
            self.setUpViewData(currentDayModel: self.weatherDayArray[0])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Table view delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "nextDayCell", for: indexPath) as? WFNextDayCell{
            if (indexPath.row < WFColors.tableViewColors.count){
                cell.backgroundColor = WFColors.tableViewColors[indexPath.row]
            }else{
                cell.backgroundColor = WFColors.tableViewColors[0]
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.setDataFromModel(currentDayModel: self.weatherDayArray[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentDayModel = self.weatherDayArray[indexPath.row]
        self.setUpViewData(currentDayModel: currentDayModel)
    }
    
    
    //To set up upper container
    func setUpViewData(currentDayModel : DayModel){
        self.locationLbl.text = (currentDayModel.city ?? "") + "," + (currentDayModel.country ?? "")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:MM"
        let result = formatter.string(from: currentDayModel.derivedDate ?? Date())
        self.timeStampLbl.text = result
        self.optimalTempLbl.text = String(currentDayModel.tempertaure?.temp ?? 0.0)
        self.tempMinMaxLbl.text = String(currentDayModel.tempertaure?.tempMin ?? 0.0) + "/" + String(currentDayModel.tempertaure?.tempMax ?? 0.0)
        self.pressureLbl.text = "Pressure : " + String(currentDayModel.tempertaure?.pressure ?? 0.0)
        self.seaLevelLbl.text = "Sea Level : " + String(currentDayModel.tempertaure?.seaLevel ?? 0.0)
        self.groundLevelLbl.text = "Ground Level : " + String(currentDayModel.tempertaure?.groundLevel ?? 0.0)
        self.humidityLbl.text = "Humidity : " + String(currentDayModel.tempertaure?.humidity ?? 0.0)
        self.weatherPrediction.text = currentDayModel.weather?.desc ?? ""
    }
    
    
}

