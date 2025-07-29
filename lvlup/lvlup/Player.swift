import Foundation
import SwiftData

@Model
class Player {
    var level: Int
    var currentXP: Double
    var xpForNextLevel: Double
    
    // We've made these non-optional and initialized them as empty arrays.
    @Relationship(deleteRule: .cascade) var skills: [Skill] = []
    @Relationship(deleteRule: .cascade) var statTrackers: [StatTracker] = []
    
    init() {
        self.level = 1
        self.currentXP = 0
        self.xpForNextLevel = 100
        // We NO LONGER create the default skills here.
    }
}
