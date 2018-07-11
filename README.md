# KRIndicatorController

**KRIndicatorController** is a controller for displaying background activity UI.

<!---
[![CI Status](http://img.shields.io/travis/Joshua Park/KRAnimationKit.svg?style=flat)](https://travis-ci.org/Joshua Park/KRAnimationKit)
--->
[![Version](https://img.shields.io/cocoapods/v/KRAnimationKit.svg?style=flat)](http://cocoapods.org/pods/KRAnimationKit)
[![License](https://img.shields.io/cocoapods/l/KRAnimationKit.svg?style=flat)](http://cocoapods.org/pods/KRAnimationKit)
[![Platform](https://img.shields.io/cocoapods/p/KRAnimationKit.svg?style=flat)](http://cocoapods.org/pods/KRAnimationKit)

## Installation
`KRIndicatorController` is available through [CocoaPods](http://cocoapods.org/). To install it, simple add the following line to your Podfile:
```
pod KRIndicatorController, :git=>'https://github.com/funct7/KRIndicatorController.git', :branch=>'develop'
```

## Usage

#### Basic
Using the default indicator view:

```
import KRIndicatorController

class ViewController: UIViewController {
    
    private let ic = IndicatorController()

    private func beginOperation() {
        // Begin some operation
        ic.increment()
    }
    
    private func endOperation() {
        // End some operation
        ic.decrement()
    }

}
```


#### Custom indicator view
Using the default indicator view:

```
import KRIndicatorController

class ViewController: UIViewController {
    
    private let ic = IndicatorController()

    private func beginOperation() {
        // Begin some operation
        ic.increment()
    }
    
    private func endOperation() {
        // End some operation
        ic.decrement()
    }

}
```

