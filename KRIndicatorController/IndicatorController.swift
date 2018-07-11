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
    
    /// A transparent background view.
    private let view: UIView
    
    /// The indicator item to display.
    public var indicatorItem: IndicatorItem {
        willSet { removeIndicatorItem() }
        didSet { addIndicatorItem() }
    }
    
    /**
     Blocks user interaction during task.
     
     Although the indicator view is displayed
     after `delay` milliseconds to avoid flickering,
     clients may want to immediately block user interaction
     to avoid unwanted input.
     
     Setting this value to `false` means
     user interaction will be blocked only when
     the indicator is actually in the view hierarchy.
     
     The default is `true`.
     */
    public var blockInteraction: Bool = true
    
    /**
     A boolean value telling whether the indicator view is currently showing.
     */
    public private(set) var isShowing: Bool = false {
        didSet { toggleIndicator(isShowing) }
    }
    
    /// The delay before showing and hiding the indicator, in milliseconds.
    public var delay: Double = 0.2
    
    /**
     The number of tasks running.
     
     - Invariant: `count >= 0`
     */
    private var count = 0
    
    /// The scheduled timer.
    private weak var timer: Timer?
    
    private var shouldStartTimer: Bool {
        return count == 0 && timer == nil
    }
    
    public init() {
        view = UIView(frame: UIScreen.main.bounds)
        
        indicatorItem = DefaultIndicator()
        
        view.addSubview(indicatorItem.view)
        
        window = UIWindow(frame: view.frame)
        window.windowLevel = UIWindowLevelAlert
        window.addSubview(view)
    }
    
    /**
     Increases the task count.
     
     The indicator is shown after the time specified in `delay`
     if the task count goes from 0 to 1.
     */
    public func increment() {
        if shouldStartTimer {
            overlayTransparentViewIfNeeded()
            startTimer()
        }
        
        count += 1
    }
    
    /**
     Decreases the task count.
     
     The indicator is hidden after the time specified in `delay`
     if the task count goes from 0 to 1.
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
     Overlays a transparent view if `blockInteraction` is `true`.
     */
    private func overlayTransparentViewIfNeeded() {
        guard blockInteraction else { return }
        overlayTransparentView()
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

