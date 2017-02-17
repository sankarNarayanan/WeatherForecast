//
//  WFLoadingSpinner.swift
//  WeatherForecast
//
//  Created by Sankar Narayanan on 17/02/17.
//  Copyright © 2017 Sankar Narayanan. All rights reserved.
//

import Foundation
import UIKit


//  MARK: - Spinner Constants
let spinnerWidth = 2.2
let animationDuration = 1.5
let spinnerSpeed = 5
let spinnerColor = UIColor.gray
let kSARRingStrokeAnimationKey = "Spinner.stroke"
let kSARRingRotationAnimationKey = "Spinner.rotation"

class WFLoadingSpinner:UIView {
    let spinnerLayer = CAShapeLayer()
    var timingFunction: CAMediaTimingFunction!
    var count = 0
    var isAnimating = false
    var timer: Timer!
    
    //MARK: -Initializers
    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override func layoutSubviews() {
        self.spinnerLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.updateProgressLayerPath()
    }
    
    //    MARK: -Setup Methods
    func setup(){
        timer = Timer.scheduledTimer(timeInterval: animationDuration, target: self, selector: #selector(WFLoadingSpinner.setSpinnerColor), userInfo: nil, repeats: true)
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        setupProgressLayer()
    }
    
    func setupProgressLayer() {
        spinnerLayer.strokeColor = spinnerColor.cgColor
        spinnerLayer.fillColor = nil
        spinnerLayer.lineWidth = CGFloat(spinnerWidth)
        self.layer.addSublayer(spinnerLayer)
        self.updateProgressLayerPath()
    }
    
    func updateProgressLayerPath() {
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = min(self.bounds.width / 2, self.bounds.height / 2) - self.spinnerLayer.lineWidth / 2
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*CGFloat(M_PI)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.spinnerLayer.path = path.cgPath
        
        self.spinnerLayer.strokeStart = 0.0
        self.spinnerLayer.strokeEnd = 0.0
    }
    
    func setSpinnerColor() {
        self.spinnerLayer.strokeColor = spinnerColor.cgColor
    }
    
    //    MARK: -Animation Methods
    func startAnimating() {
        
        if self.isAnimating {
            return
        }
        
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 4
        animation.fromValue = 0
        animation.toValue = (2 * M_PI)
        animation.repeatCount = Float.infinity
        self.spinnerLayer.add(animation, forKey: kSARRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.duration = 1
        headAnimation.fromValue = 0
        headAnimation.toValue = 0.25
        headAnimation.timingFunction = self.timingFunction
        
        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.duration = 1
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1
        tailAnimation.timingFunction = self.timingFunction;
        
        let endHeadAnimation = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnimation.beginTime = 1
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1
        endHeadAnimation.timingFunction = self.timingFunction
        
        let endTailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnimation.beginTime = 1
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1
        endTailAnimation.toValue = 1
        endTailAnimation.timingFunction = self.timingFunction
        
        let animations = CAAnimationGroup()
        animations.duration = animationDuration
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity;
        self.spinnerLayer.add(animations, forKey: kSARRingStrokeAnimationKey)
        
        
        self.isAnimating = true;
        
    }
    
    func stopAnimating() {
        if !self.isAnimating {
            return
        }
        
        self.spinnerLayer.removeAnimation(forKey: kSARRingRotationAnimationKey)
        self.spinnerLayer.removeAnimation(forKey: kSARRingStrokeAnimationKey)
        self.isAnimating = false;
        
    }
    
    //    MARK: -Memory Methods
    deinit {
        //        Release the timer here
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
}

