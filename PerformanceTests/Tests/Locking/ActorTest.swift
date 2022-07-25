//
//  ActorTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct ActorTest: Test {
    actor AtomicInt {
        // Can't mutate from outside of the actor apparently anyway
        private(set) var state: Int = 0
        
        @discardableResult
        func incrementAndGet() -> Int {
            state += 1
            return state
        }
        
        init() { }
    }
    
    var name: String = "Thread safety using Actor"
    
    func run(iterations: Int) async -> TimeInterval {
        return await timed {
            let mutableState = AtomicInt()
            
            for _ in 0..<iterations {
                await mutableState.incrementAndGet()
            }
        }
    }
}
