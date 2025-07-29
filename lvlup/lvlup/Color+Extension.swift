import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    // These colors should be defined in your Assets.xcassets
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let primaryText = Color("PrimaryTextColor")
    
    // We are re-introducing the gradients from our colorful dark theme
    let skillGradient = LinearGradient(
        gradient: Gradient(colors: [Color("SkillGradientStart"), Color("SkillGradientEnd")]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    let questBorderGradient = LinearGradient(
        gradient: Gradient(colors: [Color.pink.opacity(0.6), Color.blue.opacity(0.6)]),
        startPoint: .leading,
        endPoint: .trailing)
}
