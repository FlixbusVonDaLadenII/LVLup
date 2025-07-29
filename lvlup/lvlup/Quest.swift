import Foundation
import SwiftData

@Model
class Quest {
    @Attribute(.unique) var id: UUID
    var name: String
    var xpValue: Int
    var skillRawValue: String
    var isCompleted: Bool = false
    var isCustom: Bool
    
    var skill: SkillType {
        get { SkillType(rawValue: skillRawValue) ?? .mind }
        set { skillRawValue = newValue.rawValue }
    }
    
    init(name: String, xpValue: Int, skill: SkillType, isCustom: Bool = false) {
        self.id = UUID()
        self.name = name
        self.xpValue = xpValue
        self.skillRawValue = skill.rawValue
        self.isCustom = isCustom
    }
}
