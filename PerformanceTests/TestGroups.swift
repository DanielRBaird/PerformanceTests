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
            description: "Get the square root of a number x times using different threading techinques",
            testList: [NoThreadSwitchingTest(), DispatchQueueTest(), AsyncAwaitTest()]
        ),
        TestGroup(
            name: "Actor vs Locks",
            description: "Increment and get an int x times using different locking techniques",
            testList: [
                NoLockTest(),
                NSLockTest(),
                UnfairLockTest(),
                NSRecursiveLockTest(),
                DispatchQueueLockTest(),
                ActorTest()
            ]
        )
    ]
}
