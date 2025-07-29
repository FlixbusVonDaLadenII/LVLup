import Foundation

struct QuestLibrary {
    // This static list holds all possible quests.
    // We've removed the 'description' argument to match the new Quest model.
    static let allQuests: [Quest] = [
        // Fitness
        Quest(name: "Go for a 30-minute walk", xpValue: 50, skill: .fitness),
        Quest(name: "Complete a 7-minute workout", xpValue: 75, skill: .fitness),
        Quest(name: "Stretch for 15 minutes", xpValue: 40, skill: .fitness),
        
        // Mind
        Quest(name: "Read one chapter of a book", xpValue: 50, skill: .mind),
        Quest(name: "Solve a puzzle (Sudoku, etc.)", xpValue: 60, skill: .mind),
        Quest(name: "Learn 5 new vocabulary words", xpValue: 80, skill: .mind),
        
        // Health
        Quest(name: "Drink 8 glasses of water", xpValue: 30, skill: .health),
        Quest(name: "Eat a serving of fruit", xpValue: 25, skill: .health),
        Quest(name: "Cook a healthy meal at home", xpValue: 100, skill: .health),
        
        // Home
        Quest(name: "Organize one drawer or shelf", xpValue: 40, skill: .home),
        Quest(name: "Tidy up your desk", xpValue: 30, skill: .home),
        Quest(name: "Take out the trash/recycling", xpValue: 20, skill: .home)
    ]
}
