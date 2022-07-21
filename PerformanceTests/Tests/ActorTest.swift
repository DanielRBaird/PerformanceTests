//
//  ActorTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct ActorTest: Test {
    actor MutableStateActor {
        // Can't mutate from outside of the actor apparently anyway
        private(set) var state: Int = 0
        
        func setState(_ newState: Int) {
            state = newState
        }
        
        init() { }
    }
    
    var name: String = "Thread safety using Actor"
    
    func run(iterations: Int) async -> TimeInterval {
        return await timed {
            let mutableState = MutableStateActor()
            
            for _ in 0..<iterations {
                await mutableState.setState(await mutableState.state + 1)
            }
        }
    }
}
