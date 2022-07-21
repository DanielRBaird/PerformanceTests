//
//  PerformanceTestListView.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import SwiftUI

struct PerformanceTestListView: View {
    var groups: [TestGroup] = TestGroups.groups
    
    var body: some View {
        NavigationView {
            List(groups) { testGroup in
                NavigationLink(destination: {
                    TestRunnerView(viewModel: TestRunnerViewModel(testGroup: testGroup))
                }, label: {
                    Text(testGroup.name)
                })
            }
        }
        .navigationBarHidden(false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceTestListView()
    }
}
