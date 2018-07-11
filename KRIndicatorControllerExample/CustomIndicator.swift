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
    
    var indicatorView: UIView { return slider }
    
    private let slider: UISlider
    
    init() {
        // I don't know why anyone would do this,
        // but this is to demonstrate that you can use any view.
        slider = UISlider()
        slider.value = 0.0
    }
    
    func animateShow() {
        let anim: (Float) -> () -> Void = { (val) in
            return { self.slider.value = val }
        }
        
        UIView.animate(withDuration: 0.05) {
            anim(1.0)()
            UIView.animate(withDuration: 0.05,
                           animations: anim(0.0))
        }
    }
    
    func animateHide() {
        let anim: (Float) -> () -> Void = { (val) in
            return { self.slider.value = val }
        }
        
        UIView.animate(withDuration: 0.05) {
            anim(1.0)()
            UIView.animate(withDuration: 0.05,
                           animations: anim(0.0))
        }

    }
    
}
