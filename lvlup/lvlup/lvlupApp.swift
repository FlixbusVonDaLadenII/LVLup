import SwiftUI
import SwiftData

@main
struct LVLUPApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                Player.self,
                Skill.self,
                Quest.self,
                StatTracker.self,
                StatLog.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            let context = modelContainer.mainContext
            var playerFetchDescriptor = FetchDescriptor<Player>()
            playerFetchDescriptor.fetchLimit = 1
            
            if try context.fetch(playerFetchDescriptor).isEmpty {
                // Step 1: Create and save the player first.
                let newPlayer = Player()
                context.insert(newPlayer)
                
                // Step 2: Now create the skills.
                let defaultSkills = [
                    Skill(skillType: .fitness),
                    Skill(skillType: .mind),
                    Skill(skillType: .health),
                    Skill(skillType: .home),
                    Skill(skillType: .finance),
                    Skill(skillType: .social)
                ]
                
                for skill in defaultSkills {
                    // --- THIS IS THE FIX ---
                    // We must insert each new skill into the context before linking it.
                    context.insert(skill)
                    newPlayer.skills.append(skill)
                }
            }
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
