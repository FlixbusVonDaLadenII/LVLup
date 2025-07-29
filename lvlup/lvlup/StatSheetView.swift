import SwiftUI
import SwiftData

struct StatSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \StatTracker.creationDate) private var trackers: [StatTracker]
    
    @State private var showingAddTrackerSheet = false
    @State private var selectedTracker: StatTracker?
    
    // This adaptive grid creates columns of at least 160 points wide.
    // On most iPhones, this will result in a 2-column grid.
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            ScrollView {
                if trackers.isEmpty {
                    Text("No stats yet.\nTap the '+' in the top corner to add one.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 100)
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(trackers) { tracker in
                            Button {
                                selectedTracker = tracker
                            } label: {
                                StatCardView(tracker: tracker)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showingAddTrackerSheet) {
                AddTrackerView { selectedTrackers in
                    for tracker in selectedTrackers {
                        addTracker(predefinedTracker: tracker)
                    }
                }
            }
            .sheet(item: $selectedTracker) { tracker in
                // Present our beautiful new detail view
                NavigationView {
                    StatDetailView(tracker: tracker)
                }
            }
        }
    }
    
    private func addTracker(predefinedTracker: PredefinedTracker) {
        let newTracker = StatTracker(name: predefinedTracker.name,
                                     iconName: predefinedTracker.iconName,
                                     color: predefinedTracker.color)
        modelContext.insert(newTracker)
    }
}
