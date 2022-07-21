//
//  TestGroups.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

class TestGroups {
    static let groups: [TestGroup] = [
        TestGroup(
            name: "DispatchQueue vs Async/Await",
            testList: [NoThreadSwitchingTest(), DispatchQueueTest(), AsyncAwaitTest()]
        ),
        TestGroup(
            name: "Actor vs Locks",
            testList: [
                NoLockTest(),
                NSLockTest(),
                NSRecursiveLockTest(),
                DispatchQueueLockTest(),
                ActorTest()
            ]
        )
    ]
}
