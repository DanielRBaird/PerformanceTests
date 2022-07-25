//
//  TestRunnerViewModel.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct TestResult: Identifiable {
    var test: any Test
    var time: TimeInterval
    var id: String {
        return test.name
    }
}

@MainActor class TestRunnerViewModel: ObservableObject {
    let testGroup: TestGroup
    
    @Published var running: Bool
    
    // Test results are updated after running
    @Published var testResults: [TestResult]

    init(testGroup: TestGroup) {
        self.testGroup = testGroup
        self.running = false
        self.testResults = []
    }
    
    func run(iterations: Int) async {
        self.running = true
        
        var updatedResults = [TestResult]()
        for test in testGroup.tests() {
            print("\(Date.now): starting test: \(test.name)")
            let runTime = await test.run(iterations: iterations)
            print("\(Date.now): completed test: \(test.name)")
            updatedResults.append(TestResult(test: test, time: runTime))
        }
        
        testResults = updatedResults
        self.running = false
    }
}
