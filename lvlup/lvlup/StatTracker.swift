import Foundation
import SwiftData
import SwiftUI

@Model
class StatTracker {
    @Attribute(.unique) var id: UUID
    var name: String
    var iconName: String
    var creationDate: Date
    var goal: Double
    
    // --- THIS IS THE FIX ---
    // We store the raw color components, which SwiftData understands.
    var colorRed: Double
    var colorGreen: Double
    var colorBlue: Double
    
    // @Transient tells SwiftData to ignore this property for saving.
    // It's a convenient way for us to use the Color type in our UI.
    @Transient
    var color: Color {
        Color(red: colorRed, green: colorGreen, blue: colorBlue)
    }
    
    var totalValue: Double { logs.reduce(0) { $0 + $1.value } }
    var progress: Double {
        guard goal > 0 else { return 0 }
        return totalValue / goal
    }
    
    @Relationship(deleteRule: .cascade, inverse: \StatLog.tracker)
    var logs: [StatLog] = []
    
    // The initializer now extracts the color components and stores them.
    init(name: String, iconName: String, color: Color, goal: Double = 1000.0) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.creationDate = .now
        self.goal = goal
        
        // Extract RGBA components from the Color
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        self.colorRed = Double(r)
        self.colorGreen = Double(g)
        self.colorBlue = Double(b)
    }
}
