//
//  TestGroup.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import Foundation

struct TestGroup: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let testList: [any Test]
    
    init(name: String, description: String, testList: [any Test]) {
        self.name = name
        self.description = description
        self.testList = testList
    }
    
    func tests() -> [any Test] {
        return testList
    }
    
    static func == (lhs: TestGroup, rhs: TestGroup) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
    }
}
