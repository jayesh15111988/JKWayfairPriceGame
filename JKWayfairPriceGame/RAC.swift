//
//  RAC.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/18/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import ReactiveCocoa

// Source: https://github.com/ColinEberhardt/ReactiveSwiftFlickrSearch/tree/master/ReactiveSwiftFlickrSearch/Util

// a struct that replaces the RAC macro
struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

infix operator ~> {}
func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}