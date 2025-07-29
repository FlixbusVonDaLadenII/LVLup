import SwiftUI

struct SkillBarView: View {
    let skill: Skill
    
    private var progress: CGFloat {
        guard skill.xpForNextLevel > 0 else { return 0 }
        return CGFloat(skill.currentXP / skill.xpForNextLevel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(skill.skillType.iconEmoji)
                Text(skill.name)
                    .fontWeight(.semibold)
                Spacer()
                // --- FIX ---
                // Replaced 'Color.theme.secondaryText' with the standard '.secondary'
                Text("LVL \(skill.level)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            ProgressView(value: progress)
                .tint(skill.skillType.color)
        }
    }
}
