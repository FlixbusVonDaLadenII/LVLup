import SwiftUI

struct LevelUpView: View {
    let newLevel: Int
    var onDismiss: () -> Void
    
    @State private var animate = false

    private let splashColors: [Color] = [
        Color("SkillGradientStart"),
        Color("SkillGradientEnd"),
        .pink,
        .blue
    ]

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }

            VStack(spacing: 16) {
                ZStack {
                    colorsplashAnimation
                }
                
                Text("🎉")
                    .font(.system(size: 80))
                
                VStack {
                    Text("LEVEL UP!")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.theme.skillGradient) // Use the dark theme gradient
                    
                    Text("You've reached Level \(newLevel)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))
                    
                    Text("Keep up the great work!")
                        .font(.subheadline)
                        // Use the standard secondary color
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
                
                Spacer()
                
                Button {
                    onDismiss()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.skillGradient)
                        .cornerRadius(15)
                }
            }
            .padding(30)
            .frame(minHeight: 400)
            // Use the glass material for the background
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding(40)
            .scaleEffect(animate ? 1 : 0.5)
            .opacity(animate ? 1 : 0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0), value: animate)
        }
        .onAppear {
            animate = true
        }
    }
    
    private var colorsplashAnimation: some View {
        ForEach(0..<150) { _ in
            Circle()
                .fill(splashColors.randomElement()!)
                .frame(width: .random(in: 5...20), height: .random(in: 5...20))
                .offset(x: .random(in: -250...250), y: .random(in: -250...250))
                .scaleEffect(animate ? 1 : 0.1)
                .opacity(animate ? 0 : 1)
                .animation(
                    .easeOut(duration: 0.7).delay(.random(in: 0...0.3)),
                    value: animate
                )
        }
    }
}
