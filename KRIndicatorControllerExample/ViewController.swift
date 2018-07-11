//
//  ViewController.swift
//  KRIndicatorControllerExample
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import UIKit
import KRIndicatorController

class ViewController: UIViewController {
    
    private let ic = IndicatorController()
    
    private var useDefault = true
    
    @IBOutlet private var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func action1(_ sender: Any) {
        // Since `ic.delay` is `0.2`, i.e. 100 ms, the indicator will not show.
        // However, since `ic.blockInteraction` is `true`,
        // there will be a transparent window on top,
        // blocking user interaction for 0.1 seconds.
        simulateBeginRequest()
        simulateCallBack(after: 0.1)
    }
    
    @IBAction private func action2(_ sender: Any) {
        // The indicator view will be displayed after a delay of 0.2 seconds.
        // After the request finishes after 0.5 seconds,
        // the indicator will be displayed for an extra 0.2 seconds.
        simulateBeginRequest()
        simulateCallBack(after: 0.5)
    }
    
    @IBAction private func action3(_ sender: Any) {
        // The indicator view will be displayed after a delay of 0.2 seconds.
        // After the request finishes after 0.5 seconds,
        // the indicator will be displayed for an extra 0.2 seconds.
        simulateBeginRequest()
        simulateCallBack(after: 0.5)
        
        // During the delay after the first request is finished,
        // another request is made, so the indicator will not be hidden
        // at `t + 0.6`, where `t` is the time at which the first request was made.
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
            self.simulateBeginRequest()
            self.simulateCallBack(after: 0.5)
        }
    }
    
    private func simulateBeginRequest() {
        // Begin network request
        statusLabel.text = "Request started."
        ic.increment()
    }
    
    private func simulateCallBack(after seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now()+seconds) {
            self.statusLabel.text = "Request ended."
            self.ic.decrement()
        }
    }
    
    @IBAction private func switchViewAction(_ sender: Any) {
        useDefault = !useDefault
        
        if useDefault {
            ic.indicatorItem = DefaultIndicator()
        } else {
            ic.indicatorItem = CustomIndicator()
        }
    }

}

