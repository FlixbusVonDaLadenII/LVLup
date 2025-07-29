import SwiftUI

struct SkillCardView: View {
    let skill: Skill
    
    private var progress: CGFloat {
        guard skill.xpForNextLevel > 0 else { return 0 }
        return CGFloat(skill.currentXP / skill.xpForNextLevel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 8)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(skill.skillType.color.gradient, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                Text(skill.skillType.iconEmoji)
                    .font(.title2)
            }
            .frame(width: 50, height: 50)
            
            Spacer()
            
            Text(skill.name)
                .font(.headline)
                .fontWeight(.bold)
            
            Text("LVL \(skill.level)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(height: 160)
        .background(Color("CardBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
