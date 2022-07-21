//
//  TestGroup.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

class TestGroup: Identifiable {
    var id = UUID()
    
    let name: String
    let testList: [any Test]
    
    init(name: String, testList: [any Test]) {
        self.name = name
        self.testList = testList
    }
    
    func tests() -> [any Test] {
        return testList
    }
}
