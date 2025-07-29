import SwiftUI

struct StatDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var tracker: StatTracker
    
    @State private var newLogValue: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: Header
                ZStack {
                    Circle()
                        .stroke(tracker.color.opacity(0.2), lineWidth: 20)
                    Circle()
                        .trim(from: 0.0, to: tracker.progress)
                        .stroke(tracker.color.gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text(String(format: "%.1f", tracker.totalValue))
                            .font(.largeTitle.bold())
                        Text("/ \(Int(tracker.goal))")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 150, height: 150)
                .padding(40)
                
                // MARK: Log New Progress
                Section(header: Text("Log New Progress").font(.headline).padding(.horizontal)) {
                    HStack {
                        TextField("Enter Value", text: $newLogValue)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        
                        Button("Add") {
                            logNewValue()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(tracker.color)
                        .disabled((Double(newLogValue) ?? 0) <= 0)
                    }
                    .padding()
                }
                
                // MARK: Recent Logs
                Section(header: Text("Recent Logs").font(.headline).padding(.horizontal)) {
                    List(tracker.logs.sorted(by: { $0.date > $1.date })) { log in
                        HStack {
                            Text(log.date, style: .date)
                            Spacer()
                            Text(String(format: "%.1f", log.value))
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(tracker.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func logNewValue() {
        guard let value = Double(newLogValue), value > 0 else { return }
        let newLog = StatLog(value: value)
        tracker.logs.append(newLog)
        newLogValue = "" // Reset
    }
}
