//
//  NSLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct NSLockTest: Test {
    class AtomicInt {
        private let lock: NSLock = NSLock()
        private var _state: Int = 0

        var state: Int {
            get {
                lock.lock()
                let value = _state
                lock.unlock()
                return value
            }
        }
        
        @discardableResult
        func incrementAndGet() -> Int {
            lock.lock()
            _state += 1
            let current = _state
            lock.unlock()
            return current
        }
        
        init() { }
    }

    var name: String = "Thread safety using NSLock"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = AtomicInt()
            
            for _ in 0..<iterations {
                mutableState.incrementAndGet()
            }
        }
    }
}
