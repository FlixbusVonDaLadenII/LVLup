import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var players: [Player]
    private var player: Player { players.first! }
    
    @Query(sort: \Quest.name) private var quests: [Quest]
    private var skills: [Skill] { player.skills.sorted(by: { $0.name < $1.name }) }
    
    @State private var skillsIsExpanded: Bool = true
    @State private var questsIsExpanded: Bool = true
    @State private var showingAddQuestSheet = false
    @State private var showingPaywallSheet = false
    @StateObject private var storeManager = StoreManager()
    @State private var showingLevelUpView = false

    private var levelProgress: CGFloat {
        guard player.xpForNextLevel > 0 else { return 0 }
        return CGFloat(player.currentXP / player.xpForNextLevel)
    }
    
    init() {}
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    profileHeaderView
                    skillsView
                    questListView
                }
                .padding(.vertical)
            }
            .sheet(isPresented: $showingAddQuestSheet) { AddQuestView(onSave: { newQuest in addQuest(newQuest) }) }
            .sheet(isPresented: $showingPaywallSheet) { PaywallView().environmentObject(storeManager) }
            .onAppear(perform: generateDailyQuestsIfNeeded)
            
            if showingLevelUpView {
                LevelUpView(newLevel: player.level) {
                    showingLevelUpView = false
                }
            }
        }
    }
    
    func generateDailyQuestsIfNeeded() {
        do {
            let descriptor = FetchDescriptor<Quest>(predicate: #Predicate { quest in
                !quest.isCustom && !quest.isCompleted
            })
            let incompleteDailyQuests = try modelContext.fetch(descriptor)
            if incompleteDailyQuests.isEmpty {
                let randomQuests = QuestLibrary.allQuests.shuffled().prefix(4)
                for questBlueprint in randomQuests {
                    let newQuest = Quest(name: questBlueprint.name, xpValue: questBlueprint.xpValue, skill: questBlueprint.skill)
                    modelContext.insert(newQuest)
                }
            }
        } catch {
            print("Failed to fetch quests for generation: \(error)")
        }
    }
    func addQuest(_ quest: Quest) { modelContext.insert(quest) }
    func completeQuest(_ quest: Quest) {
        guard !quest.isCompleted else { return }
        withAnimation(.easeOut) {
            quest.isCompleted = true
            if let skillToUpdate = skills.first(where: { $0.name == quest.skill.rawValue }) {
                skillToUpdate.currentXP += Double(quest.xpValue)
                if skillToUpdate.currentXP >= skillToUpdate.xpForNextLevel {
                    skillToUpdate.level += 1
                    let remainingXP = skillToUpdate.currentXP - skillToUpdate.xpForNextLevel;
                    skillToUpdate.currentXP = remainingXP
                    skillToUpdate.xpForNextLevel *= 1.2
                }
            }
            player.currentXP += Double(quest.xpValue) / 2
            if player.currentXP >= player.xpForNextLevel {
                levelUp()
            }
        }
    }
    func levelUp() {
        let remainingXP = player.currentXP - player.xpForNextLevel
        player.level += 1
        player.currentXP = remainingXP
        player.xpForNextLevel *= 1.5
        showingLevelUpView = true
    }
    
    private var profileHeaderView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome Back,").font(.subheadline).foregroundStyle(.secondary)
                Text("Aspiring Achiever").font(.largeTitle).fontWeight(.bold)
            }
            Spacer()
            Button(action: levelUp) {
                ZStack {
                    Circle().stroke(lineWidth: 10).opacity(0.2).foregroundColor(.gray)
                    Circle().trim(from: 0.0, to: levelProgress)
                        .stroke(Color.theme.questBorderGradient, style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: -90))
                    Text("\(player.level)").font(.title).fontWeight(.bold)
                }
                .frame(width: 70, height: 70)
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
    private var skillsView: some View {
        VStack(spacing: 15) {
            HStack {
                Text("SKILLS").font(.headline).foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "chevron.down").rotationEffect(.degrees(skillsIsExpanded ? 0 : -90))
            }
            .contentShape(Rectangle())
            .onTapGesture { withAnimation(.spring()) { skillsIsExpanded.toggle() } }
            if skillsIsExpanded {
                ForEach(skills) { skill in
                    SkillBarView(skill: skill)
                }
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .padding(.horizontal)
    }
    private var questListView: some View {
        VStack(spacing: 15) {
            HStack {
                Text("DAILY QUESTS").font(.headline).foregroundStyle(.secondary)
                Spacer()
                Button{if storeManager.isProUser{showingAddQuestSheet=true}else{showingPaywallSheet=true}}label:{Image(systemName:"plus.circle.fill").font(.title2).foregroundColor(Color.theme.accent)}
            }
            .contentShape(Rectangle())
            .onTapGesture { withAnimation(.spring()) { questsIsExpanded.toggle() } }
            if questsIsExpanded {
                if quests.isEmpty {
                    Text("No quests available. Add a custom one!").font(.headline).foregroundStyle(.secondary).padding()
                } else {
                    VStack(spacing: 15) {
                        ForEach(quests) { quest in
                            QuestRowView(quest: quest, onComplete: { completeQuest(quest) })
                        }
                    }
                }
            }
        }
        .padding()
        .background(ZStack{Color.blue.opacity(0.1);Color.clear.background(.ultraThinMaterial)})
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
