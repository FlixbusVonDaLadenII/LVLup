import Foundation
import SwiftData

@Model
class Skill {
    var name: String
    var level: Int
    var currentXP: Double
    var xpForNextLevel: Double
    
    // This new helper converts the skill's name back to its SkillType,
    // allowing us to access the emoji.
    var skillType: SkillType {
        SkillType(rawValue: name) ?? .mind // Default to 'mind' if lookup fails
    }
    
    init(skillType: SkillType) {
        self.name = skillType.rawValue
        self.level = 1
        self.currentXP = 0
        self.xpForNextLevel = 100
    }
}
