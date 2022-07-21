//
//  NSRecursiveLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation


struct NSRecursiveLockTest: Test {
    
    class MutableStateClass {
        private let lock: NSRecursiveLock = NSRecursiveLock()
        private var _state: Int = 0

        public var state: Int {
            get {
                lock.lock()
                let value = _state
                lock.unlock()
                return value
            }
            set {
                lock.lock()
                _state = newValue
                lock.unlock()
            }
        }
        
        public init() { }
    }
    
    var name: String = "Thread safety using NSRecursiveLock"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = MutableStateClass()
            
            for _ in 0..<iterations {
                mutableState.state = mutableState.state + 1
            }
        }
    }
}
