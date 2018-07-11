//
//  CustomIndicator.swift
//  KRIndicatorControllerExample
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import UIKit
import KRIndicatorController

class CustomIndicator: IndicatorItem {
    
    var view: UIView { return sw }
    
    private let sw: UISwitch
    
    init() {
        // I don't know why anyone would do this,
        // but this is to demonstrate that you can use any view.
        sw = UISwitch()
        sw.center.x = UIScreen.main.bounds.midX
        sw.center.y = UIScreen.main.bounds.midY
        sw.isOn = false
    }
    
    func animateShow() {
        UIView.animate(withDuration: 0.2) {
            self.sw.isOn = true
        }
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.2) {
            self.sw.isOn = false
        }
    }
    
}
