import SwiftUI

struct AddTrackerView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let allTrackers = StatTrackerLibrary.allTrackers
    @State private var selections: Set<UUID> = []
    var onApply: ([PredefinedTracker]) -> Void
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(allTrackers) { tracker in
                            trackerButton(for: tracker)
                        }
                    }
                    .padding()
                }
                
                if !selections.isEmpty {
                    applyButton
                        .padding()
                }
            }
            .navigationTitle("Add New Stats")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    private func trackerButton(for tracker: PredefinedTracker) -> some View {
        let isSelected = selections.contains(tracker.id)
        
        return Button {
            if isSelected {
                selections.remove(tracker.id)
            } else {
                selections.insert(tracker.id)
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: tracker.iconName)
                    .font(.title2)
                Text(tracker.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(8)
            .frame(minHeight: 100)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            // --- FIX ---
            // Replaced the old color names with styles that work in the dark theme.
            .background(
                ZStack {
                    if isSelected {
                        Color.theme.skillGradient
                    } else {
                        Color.clear.background(.ultraThinMaterial)
                    }
                }
            )
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.theme.accent : Color.white.opacity(0.2), lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
    
    private var applyButton: some View {
        Button {
            let selectedTrackers = allTrackers.filter { selections.contains($0.id) }
            onApply(selectedTrackers)
            dismiss()
        } label: {
            Text("Apply (\(selections.count))")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.skillGradient)
                .cornerRadius(15)
        }
    }
}
