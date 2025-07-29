import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = "Dashboard"
    
    @State private var showingAddTrackerSheet = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "square.grid.2x2.fill")
                    }
                    .tag("Dashboard")
                
                StatSheetView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.xaxis")
                    }
                    .tag("Stats")
            }
            .navigationTitle(selectedTab)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if selectedTab == "Stats" {
                    Button {
                        showingAddTrackerSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTrackerSheet) {
                AddTrackerView { selectedTrackers in
                    for tracker in selectedTrackers {
                        addTracker(predefinedTracker: tracker)
                    }
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.theme.background, for: .navigationBar)
        }
        // Enforce the dark theme you prefer
        .preferredColorScheme(.dark)
    }
    
    private func addTracker(predefinedTracker: PredefinedTracker) {
        let newTracker = StatTracker(name: predefinedTracker.name,
                                     iconName: predefinedTracker.iconName,
                                     color: predefinedTracker.color)
        modelContext.insert(newTracker)
    }
}
