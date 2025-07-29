import SwiftUI

struct AddQuestView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var xpValue: Int = 50
    @State private var selectedSkill: SkillType = .mind
    
    var onSave: (Quest) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Quest Details")) {
                    TextField("Quest Name (e.g., 'Learn SwiftUI')", text: $name)
                    
                    Picker("Skill", selection: $selectedSkill) {
                        // We use CaseIterable to list all skills automatically
                        ForEach(SkillType.allCases, id: \.self) { skill in
                            Text(skill.rawValue).tag(skill)
                        }
                    }
                    
                    Stepper("XP Value: \(xpValue)", value: $xpValue, in: 10...500, step: 5)
                }
                
                Section {
                    Button("Save Quest") {
                        // When saving, we now mark the quest as custom.
                        let newQuest = Quest(name: name, xpValue: xpValue, skill: selectedSkill, isCustom: true)
                        onSave(newQuest)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("New Custom Quest")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
        }
    }
}
