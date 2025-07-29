import SwiftUI

// A simple blueprint for a stat type we can offer.
struct PredefinedTracker: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let color: Color // Each tracker now has a unique color
}

struct StatTrackerLibrary {
    static let allTrackers: [PredefinedTracker] = [
        // Health & Fitness
        PredefinedTracker(name: "Kilometers Ran/Walked", iconName: "figure.run", color: .green),
        PredefinedTracker(name: "Workouts Completed", iconName: "flame.fill", color: .red),
        PredefinedTracker(name: "Hours Slept", iconName: "bed.double.fill", color: .indigo),
        PredefinedTracker(name: "Water Drank (Liters)", iconName: "drop.fill", color: .cyan),
        
        // Mind & Productivity
        PredefinedTracker(name: "Productive Hours", iconName: "brain.head.profile", color: .purple),
        PredefinedTracker(name: "Books Read", iconName: "books.vertical.fill", color: .brown),
        PredefinedTracker(name: "Skills Learned", iconName: "star.fill", color: .yellow),
        PredefinedTracker(name: "Hours Meditated", iconName: "timelapse", color: .teal),
        
        // Finance
        PredefinedTracker(name: "Money Saved", iconName: "dollarsign.circle.fill", color: .mint),
        PredefinedTracker(name: "Debt Paid Off", iconName: "creditcard.circle.fill", color: .orange),
        PredefinedTracker(name: "No-Spend Days", iconName: "calendar", color: .gray),

        // Habits & Streaks
        PredefinedTracker(name: "Days Without Smoking", iconName: "smoke.fill", color: .pink),
        PredefinedTracker(name: "Days Without Alcohol", iconName: "wineglass", color: .blue),
        
        // Personal & Social
        PredefinedTracker(name: "Days in a Relationship", iconName: "heart.fill", color: .red),
        PredefinedTracker(name: "Acts of Kindness", iconName: "gift.fill", color: .yellow),
        PredefinedTracker(name: "New Places Visited", iconName: "map.fill", color: .green)
    ]
}
