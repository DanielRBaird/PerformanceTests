//
//  PerformanceTestListView.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import SwiftUI

struct PerformanceTestListView: View {
    var groups: [TestGroup] = TestGroups.groups
    @State var selection: TestGroup?

    init() {
        if UIDevice.current.userInterfaceIdiom != .phone {
            _selection = State(initialValue: groups.first)
        }
    }
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(groups, selection: $selection) { testGroup in
                Text(testGroup.name).tag(testGroup)
            }
            .navigationTitle("Test groups")
        }, detail: {
            // Workaround for the fact that SwiftUI kinda sucks.
            // Navigation split has a bug where it doesn't update
            // it's detail view correctly, but this is fixed by wrapping
            // it in a zstack.
            // https://developer.apple.com/forums/thread/707924
            // Unfortunately, i'm still having problems with this on ipad.
            ZStack {
                if let selection = selection {
                    TestRunnerView(viewModel: TestRunnerViewModel(testGroup: selection))
                } else {
                    Text("Choose a test to run").font(.title)
                }
            }
        })
        .navigationSplitViewStyle(.balanced)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceTestListView()
    }
}
