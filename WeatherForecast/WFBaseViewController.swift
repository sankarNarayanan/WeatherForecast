//
//  WFBaseViewController.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class WFBaseViewController: UIViewController{
    
    var overlayView : UIView?
    let labelText = "Loading..."
    var spinner : WFLoadingSpinner!
    
    func showActivityView() {
        
        self.overlayView = UIView(frame: UIScreen.main.bounds)
        
        if spinner == nil {
            spinner = WFLoadingSpinner()
        }
        self.overlayView!.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6)
        //rounded box
        let testFrame : CGRect = CGRect(x: self.view.frame.width/2-40, y:self.view.frame.height/2-40, width: 80, height: 80)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.white
        testView.layer.cornerRadius = 8.0
        spinner.startAnimating()
        let frm = CGRect(x: self.view.frame.width/2-20,y: self.view.frame.height/2-20,width: 40,height: 40)
        spinner.frame = frm
        self.overlayView!.addSubview(testView)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.addSubview(self.overlayView!)
        appDelegate.window!.addSubview(spinner)
        
    }
    
    func hideActivityView(){
        if (self.overlayView != nil){
            self.spinner.stopAnimating()
            self.overlayView!.removeFromSuperview()
        }
    }
    
}


