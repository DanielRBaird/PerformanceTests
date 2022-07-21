//
//  AsyncAwaitTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct AsyncAwaitTest: Test {    
    var name: String = "Async using async/await"
    
    public func run(iterations: Int) async -> TimeInterval {
        return await timed {
            await testDoSomethingAsync(iterations: iterations)
        }
    }
    
    public func testDoSomethingAsync(iterations: Int) async {
        await withTaskGroup(of: Double.self, returning: Void.self, body: { taskGroup in
            for i in 0..<iterations {
                taskGroup.addTask {
                    return await doSomethingAsync(value: i)
                }
            }
        })
    }

    public func doSomethingAsync(value: Int) async -> Double {
        return sqrt(Double(value))
    }
}
