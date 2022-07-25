//
//  TestRunnerView.swift
//  PerformanceTests
//
//  Created by Daniel Baird on 7/21/22.
//

import SwiftUI
import Charts

struct TestRunnerView: View {
    @StateObject var viewModel: TestRunnerViewModel
    @State var iterationMagnitude: Double = 5 // 10^5
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.testGroup.description)
                .padding()
            Spacer()
            VStack(alignment: .center) {
                if !viewModel.running && !viewModel.testResults.isEmpty {
                    Chart {
                        ForEach(viewModel.testResults) { result in
                            BarMark(
                                x: .value("Time", result.time),
                                y: .value("Test name", result.test.name)
                            )
                        }
                    }.padding()
                } else if viewModel.running {
                    ProgressView()
                } else {
                    Chart {
                        EmptyChartContent()
                    }
                }
            }.frame(maxWidth: .infinity)
            Spacer()
            Divider()
            
            VStack(alignment: .leading) {
                Text("Configuration")
                    .font(.title)
                    .padding()
                
                Stepper(
                    value: $iterationMagnitude,
                    in: 0...7,
                    step: 1) {
                        Text("Iterations: \(Int(pow(10, iterationMagnitude)))")
                    }.padding()
                
                Button(action: {
                    Task {
                        await viewModel.run(iterations: Int(pow(10, iterationMagnitude)))
                    }
                }, label: {
                    Text("Run")
                        .bold()
                })
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(viewModel.testGroup.name)
    }
}

struct TestRunnerView_Previews: PreviewProvider {
    static var previews: some View {
        TestRunnerView(
            viewModel: TestRunnerViewModel(testGroup: TestGroups.groups.first!)
        )
    }
}
