import SwiftUI

struct QuestRowView: View {
    let quest: Quest
    var onComplete: () -> Void

    var body: some View {
        Button(action: {
            onComplete()
        }) {
            HStack(spacing: 16) {
                Text(quest.skill.iconEmoji)
                    .font(.title2)
                    .padding(12)
                    .background(quest.skill.color.opacity(0.1))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    if quest.isCompleted {
                        Text("Task Done")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                        
                        Text(quest.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .strikethrough()
                        
                    } else {
                        Text(quest.name)
                            .fontWeight(.bold)
                            // Use the primary text color from our theme
                            .foregroundStyle(Color.theme.primaryText)
                        
                        Text("+\(quest.xpValue) XP")
                            .font(.caption)
                            // Use the standard secondary color
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Image(systemName: quest.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(quest.isCompleted ? .green : .secondary)
            }
            .padding()
            // Use the glass material background
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.questBorderGradient, lineWidth: 2)
            )
            .opacity(quest.isCompleted ? 0.7 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(quest.isCompleted)
    }
}
