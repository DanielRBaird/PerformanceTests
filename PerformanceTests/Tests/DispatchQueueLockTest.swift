//
//  DispatchQueueLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct DispatchQueueLockTest: Test {
    class AtomicInt {
        private let dispatchQueue: DispatchQueue = DispatchQueue(label: "atomicInt")
        private var _state: Int = 0

        var state: Int {
            get {
                return dispatchQueue.sync {
                    let value = _state
                    return value
                }
            }
        }
        
        @discardableResult
        func incrementAndGet() -> Int {
            return dispatchQueue.sync {
                _state += 1
                return _state
            }
        }
        
        init() { }
    }

    var name: String = "Thread safety using dispatch queue"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = AtomicInt()
            
            for _ in 0..<iterations {
                mutableState.incrementAndGet()
            }
        }
    }
}
