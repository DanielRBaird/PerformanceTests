//
//  Test.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

protocol Test: Hashable, Equatable {
    var name: String { get }
    func run(iterations: Int) async -> TimeInterval
}

extension Test {
    func timed(_ task: () async -> Void) async -> TimeInterval {
        let startDate = Date.now
        await task()
        return Date.now.timeIntervalSince(startDate)
    }

    func timed(_ task: () -> Void) -> TimeInterval {
        let startDate = Date.now
        task()
        return Date.now.timeIntervalSince(startDate)
    }

}
