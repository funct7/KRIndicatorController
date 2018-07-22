//
//  IndicatorController.swift
//  KRIndicatorController
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import UIKit

/**
 An activity indicator controller.
 */
public class IndicatorController {
    
    private let window: UIWindow
    
    /// The placeholder root view controller of the window.
    private let vc = UIViewController()
    
    /// A transparent background view.
    private var view: UIView { return vc.view! }
    
    /// The indicator item to display.
    public var indicatorItem: IndicatorItem {
        willSet { removeIndicatorItem() }
        didSet { addIndicatorItem() }
    }
    
    /**
     A boolean value that determines whether
     user interaction with the underlying views
     is blocked while the indicator is displayed.
     
     The default is `true`.
     */
    public var isUserInteractionBlocked: Bool {
        get { return window.isUserInteractionEnabled }
        set { window.isUserInteractionEnabled = newValue }
    }
    
    /**
     A boolean value telling whether the indicator view is currently showing.
     */
    public private(set) var isShowing: Bool = false {
        didSet { toggleIndicator(isShowing) }
    }
    
    /**
     The delay before showing and hiding the indicator, in seconds.
     
     The default is `0.2`; i.e. 200 ms.
     */
    public var delay: Double = 0.2
    
    /**
     The number of tasks running.
     
     - Invariant: `count >= 0`
     
     - Important:
        It is the responsibility of the client to balance
        calls to `increment()` and `decrement()`.
     */
    private var count = 0
    
    /// The scheduled timer.
    private weak var timer: Timer?
    
    private var shouldStartTimer: Bool {
        return count == 0 && timer == nil
    }
    
    public init() {
        indicatorItem = DefaultIndicator()
        
        vc.view.addSubview(indicatorItem.view)
        
        window = UIWindow(frame: vc.view.frame)
        window.windowLevel = UIWindowLevelAlert
        window.rootViewController = vc
        window.isHidden = true
    }
    
    /**
     Increases the task count.
     
     The indicator is shown after the time specified in `delay`
     if the task count goes from 0 to 1.
     */
    public func increment() {
        if shouldStartTimer {
            overlayTransparentView()
            startTimer()
        }
        
        count += 1
    }
    
    /**
     Decreases the task count.
     
     The indicator is hidden after the time specified in `delay`
     if the task count goes from 1 to 0.
     */
    public func decrement() {
        count -= 1
        
        if shouldStartTimer { startTimer() }
    }
    
    // MARK: - Private
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: delay,
                                     target: self,
                                     selector: #selector(timerDidFire(_:)),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc private func timerDidFire(_ t: Timer) {
        assert(count >= 0)
        
        isShowing = count > 0
        self.timer = nil
    }
    
    /**
     Overlays a transparent view to discourage users from interacting with the screen.
     */
    private func overlayTransparentView() {
        window.isHidden = false
        view.isHidden = false
        indicatorItem.view.isHidden = true
    }
    
    private func toggleIndicator(_ isOn: Bool) {
        let block: () -> Void = {
            self.window.isHidden = !isOn
            self.view.isHidden = !isOn
            self.indicatorItem.view.isHidden = !isOn
        }
        
        if isOn {
            block()
            
            indicatorItem.animateShow()
        } else {
            indicatorItem.animateHide()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+delay,
                                          execute: block)
        }
    }
    
    // MARK: - Indicator Item
    
    private func removeIndicatorItem() {
        indicatorItem.view.removeFromSuperview()
    }
    
    private func addIndicatorItem() {
        view.addSubview(indicatorItem.view)
    }
    
}

