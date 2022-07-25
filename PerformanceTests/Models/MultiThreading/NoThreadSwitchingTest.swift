//
//  NoThreadSwitchingTest.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct NoThreadSwitchingTest : Test {
    var name: String = "No thread switching"
    
    func run(iterations: Int) async -> TimeInterval {
        return timed {
            for i in 0..<iterations {
                _ = doSomething(value: i)
            }
        }
    }
    
    @discardableResult
    private func doSomething(value: Int) -> Double {
        return sqrt(Double(value))
    }
}
