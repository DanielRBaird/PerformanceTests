//
//  NoLockTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

// This is like the other lock tests but just showing what the underlying work is without a lock.
struct NoLockTest: Test {
    
    class MutableStateClass {
        public var state: Int = 0
        public init() { }
    }
    
    var name: String = "No thread safety"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            let mutableState = MutableStateClass()
            
            for _ in 0..<iterations {
                mutableState.state += 1
            }
        }
    }
}
