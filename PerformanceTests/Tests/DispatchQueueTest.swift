//
//  DispatchGroupTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct DispatchQueueTest : Test {    
    var name: String = "Async using dispatch queue"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            testDoSomethingWithCallback(iterations: iterations)
        }
    }
    
    private func doSomethingWithCallback(value: Int, callback: @escaping (Int, Double) -> Void) {
        DispatchQueue.global().async {
            callback(value, sqrt(Double(value)))
        }
    }
    
    private func testDoSomethingWithCallback(iterations: Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        for i in 0..<iterations {
            doSomethingWithCallback(value: i, callback: { value, response in
                // DispatchQueue is... a queue, so the last one in should be the last one out in this case,
                // so this should be a valid assumption.
                if value == iterations-1 {
                    dispatchGroup.leave()
                }
            })
        }
        
        dispatchGroup.wait()
    }
}
