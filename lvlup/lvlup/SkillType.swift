import SwiftUI

enum SkillType: String, CaseIterable {
    case fitness = "Fitness"
    case mind = "Mind"
    case health = "Health"
    case home = "Home"
    case finance = "Finance"
    case social = "Social"
    
    var iconEmoji: String {
        switch self {
        case .fitness: return "💪"
        case .mind:    return "🧠"
        case .health:  return "🍎"
        case .home:    return "🏡"
        case .finance: return "💵"
        case .social:  return "🤝"
        }
    }
    
    // This new property provides a unique color for each skill's progress bar.
    var color: Color {
        switch self {
        case .fitness: return .orange
        case .mind:    return .purple
        case .health:  return .green
        case .home:    return .brown
        case .finance: return .blue
        case .social:  return .pink
        }
    }
}
