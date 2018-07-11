//
//  KRIndicatorControllerTests.swift
//  KRIndicatorControllerTests
//
//  Created by Joshua Park on 11/07/2018.
//  Copyright © 2018 Knowre. All rights reserved.
//

import XCTest
@testable import KRIndicatorController

class KRIndicatorControllerTests: XCTestCase {
    
    /**
     Tests a condition where the indicator is not shown
     because the activity finished before the pre-delay timer fired.
     */
    func testIndicatorQuelled() {
        let exp1 = expectation(description: "signal once"),
            exp2 = expectation(description: "signal five times")
        
        let ic = IndicatorController()
        
        ic.increment()
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            ic.decrement()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(ic.isShowing)
            exp1.fulfill()
        }
        
        wait(for: [exp1], timeout: 2.0)
        
        for _ in 0 ..< 5 { ic.increment() }
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            for _ in 0 ..< 5 { ic.decrement() }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(ic.isShowing)
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 2.0)
    }
    
    /**
     Tests a condition where the indicator is shown and removed.
     */
    func testIndicator() {
        let ic = IndicatorController()
        
        incOnceAndFire(ic)
        decOnceAndFire(ic)
        
        incFiveTimesAndFire(ic)
        decFourTimesAndWait(ic)
        decOnceAndFire(ic)
    }
    
    private func incOnceAndFire(_ ic: IndicatorController) {
        let exp = expectation(description: #function)
        ic.increment()
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    private func decOnceAndFire(_ ic: IndicatorController) {
        let exp = expectation(description: #function)
        
        ic.decrement()
        
        XCTAssertTrue(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(ic.isShowing)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    private func incFiveTimesAndFire(_ ic: IndicatorController) {
        let exp = expectation(description: #function)
        for _ in 0 ..< 5 { ic.increment() }
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    private func decFourTimesAndWait(_ ic: IndicatorController) {
        let exp = expectation(description: #function)
        
        for _ in 0 ..< 4 { ic.decrement() }
        
        XCTAssertTrue(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    /**
     Tests a condition where the indicator is extended beyond the original time frame
     because a new activity was registered before the post-delay timer fired.
     */
    func testIndicatorExtended() {
        let exp1 = expectation(description: "increment once"),
            exp2 = expectation(description: "increment before fire"),
            exp3 = expectation(description: "decrement once")
        
        let ic = IndicatorController()
        
        ic.increment()
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
            exp1.fulfill()
        }
        
        wait(for: [exp1], timeout: 2.0)
        
        ic.decrement()
        
        XCTAssertTrue(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            ic.increment()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 2.0)
        
        ic.decrement()
        
        XCTAssertTrue(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(ic.isShowing)
            exp3.fulfill()
        }
        
        wait(for: [exp3], timeout: 2.0)
    }
    
    /**
     Tests whether a delay value other than the default value is actually used.
     */
    func testDifferentDelay() {
        let exp1 = expectation(description: "delay set to 1.0"),
            exp2 = expectation(description: "decrement once")
        
        let ic = IndicatorController()
        ic.delay = 1.0
        
        ic.increment()
        
        XCTAssertFalse(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(ic.isShowing)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertTrue(ic.isShowing)
            exp1.fulfill()
        }
        
        wait(for: [exp1], timeout: 2.0)
        
        ic.decrement()
        
        XCTAssertTrue(ic.isShowing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(ic.isShowing)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertFalse(ic.isShowing)
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 2.0)
    }

}
