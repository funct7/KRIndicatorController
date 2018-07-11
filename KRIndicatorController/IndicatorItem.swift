//
//  IndicatorItem.swift
//  KRIndicatorController
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import UIKit

/**
 A protocol to be adopted by items that are designed
 to be shown by the `IndicatorController`.
 */
public protocol IndicatorItem {
 
    /// The activity indicator to be shown.
    var indicatorView: UIView { get }
    
    /**
     Animates the `indicatorView` as it appears on the screen.
     
     Run your own UIView animation blocks or CAAnimations inside the method,
     as this method will *NOT* be run within a UIView animation block.
     
     - Note:
        Make sure the animation duration is less than or equal to
        the `delay` value of the `IndicatorController` object
        this item will be associated to.
        Othewise, the behavior is undefined.
     */
    func animateShow()
    
    /**
     Animates the `indicatorView` disappearing from screen.
     
     Run your own UIView animation blocks or CAAnimations inside the method,
     as this method will *NOT* be run within a UIView animation block.
     
     - Note:
         Make sure the animation duration is less than or equal to
         the `delay` value of the `IndicatorController` object
         this item will be associated to.
         Othewise, the behavior is undefined.
     */
    func animateHide()
    
}
