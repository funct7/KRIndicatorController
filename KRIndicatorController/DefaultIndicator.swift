//
//  DefaultIndicator.swift
//  KRIndicatorController
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import UIKit

public struct DefaultIndicator: IndicatorItem {
    
    public var indicatorView: UIView { return aiView }
    
    private let aiView: UIActivityIndicatorView
    
    public init() {
        aiView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        aiView.alpha = 0.0
        aiView.color = UIColor.darkGray
        aiView.center.x = UIScreen.main.bounds.midX
        aiView.center.y = UIScreen.main.bounds.midY
        aiView.hidesWhenStopped = false
    }
    
    public func animateShow() {
        aiView.startAnimating()
        
        UIView.animate(withDuration: 0.15) {
            self.aiView.alpha = 1.0
        }
    }
    
    public func animateHide() {
        let anim = { self.aiView.alpha = 0.0 },
            comp = { (_: Bool) in self.aiView.stopAnimating() }
        
        UIView.animate(withDuration: 0.15,
                       animations: anim,
                       completion: comp)
    }
    
}
