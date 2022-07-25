//
//  UnfairLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/25/22.
//

import Foundation


struct UnfairLockTest: Test {
    class AtomicInt {
        // I have seen questions as to if this is actually safe in swift due to it being a struct
        // which apparently means that it's memory location may not be stable. But we will test it anyway.
        private var lock = os_unfair_lock_s()
        private var state: Int = 0
        
        @discardableResult
        func incrementAndGet() -> Int {
            os_unfair_lock_lock(&lock)
            state += 1
            let current = state
            os_unfair_lock_unlock(&lock)
            return current
        }
        
        init() { }
    }

    var name: String = "Thread safety using os_unfair_lock"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = AtomicInt()
            
            for _ in 0..<iterations {
                mutableState.incrementAndGet()
            }
        }
    }
}
