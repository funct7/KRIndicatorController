# KRIndicatorController

**KRIndicatorController** is a controller for displaying background activity UI.

<!---
[![CI Status](http://img.shields.io/travis/Joshua Park/KRIndicatorController.svg?style=flat)](https://travis-ci.org/Joshua Park/KRIndicatorController)
--->
[![Version](https://img.shields.io/cocoapods/v/KRIndicatorControllerKit.svg?style=flat)](http://cocoapods.org/pods/KRIndicatorController)
[![License](https://img.shields.io/cocoapods/l/KRIndicatorController.svg?style=flat)](http://cocoapods.org/pods/KRIndicatorController)
[![Platform](https://img.shields.io/cocoapods/p/KRIndicatorController.svg?style=flat)](http://cocoapods.org/pods/KRIndicatorController)

## Installation
`KRIndicatorController` is available through [CocoaPods](http://cocoapods.org/). To install it, simply add the following line to your Podfile:
```ruby
pod 'KRIndicatorController'
```

Then, run the following command:
```bash
$ pod install
```

## Usage

#### Basic
Using the default indicator view:

```swift
import KRIndicatorController

class ViewController: UIViewController {
    
    private let ic = IndicatorController()

    private func beginOperation() {
        ic.increment()

        // Begin some operation
    }
    
    private func endOperation() {
        // End some operation
        
        ic.decrement()
    }

}
```


#### Custom indicator view
Using a custom indicator view:

```swift
import KRIndicatorController

class CustomIndicator: IndicatorItem {
    
    var view: UIView
    init() {
        // Initialize
    }
    
    func animateShow() {
        // Custom animation
    }
    
    func animateHide() {
        // Custom animation
    }
    
}

class ViewController: UIViewController {
    
    private let ic = IndicatorController()

    private func setCustomIndicatorView() {
        ic.indicatorItem = CustomIndicator()
    }

}
```

#### Custom delay
Setting a custom delay value:

```swift
import KRIndicatorController

class ViewController: UIViewController {
    
    private let ic = IndicatorController()

    private func setCustomDelay() {
        ic.delay = 0.3  // 300 ms delay
    }

}
```

#### Block/allow user interaction
Blocking the user interaction during indicator display:

```swift
import KRIndicatorController

class ViewController: UIViewController {

    private let ic = IndicatorController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ic.isUserInteractionBlocked = true // Default is true
    }

}
```

Setting `isUserInteractionBlocked` to `false` allows users to interact with the underlying view.