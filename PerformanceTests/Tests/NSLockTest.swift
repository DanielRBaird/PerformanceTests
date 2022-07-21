//
//  NSLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct NSLockTest: Test {
    class MutableStateClass {
        private let lock: NSLock = NSLock()
        private var _state: Int = 0

        var state: Int {
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
        
        init() { }
    }

    var name: String = "Thread safety using NSLock"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = MutableStateClass()
            
            for _ in 0..<iterations {
                mutableState.state = mutableState.state + 1
            }
        }
    }
}
