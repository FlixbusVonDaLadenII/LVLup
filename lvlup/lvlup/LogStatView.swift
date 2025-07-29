//
//  LogStatView.swift
//  lvlup
//
//  Created by Felix on 25.07.25.
//


import SwiftUI
import SwiftData

struct LogStatView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // The view is created for a specific tracker.
    let tracker: StatTracker
    
    @State private var value: Double = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Log New Entry") {
                    Text("Add a new value for \(tracker.name)")
                    
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Save Entry") {
                        // Create the new log and add it to the tracker.
                        let newLog = StatLog(value: value)
                        tracker.logs.append(newLog)
                        dismiss()
                    }
                    .disabled(value <= 0)
                }
            }
            .navigationTitle("New Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
