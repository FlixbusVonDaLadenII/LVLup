import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("LVLUP Pro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.skillGradient)
                
                // --- FIX #1 ---
                // Replaced 'secondaryText' with the standard '.secondary' color
                Text("Unlock Your Full Potential")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                // Feature List
                VStack(alignment: .leading, spacing: 20) {
                    featureRow(icon: "plus.app.fill", title: "Create Custom Quests", subtitle: "Add your own personal goals and tasks.")
                    featureRow(icon: "chart.pie.fill", title: "Detailed Statistics", subtitle: "Track your progress with beautiful charts.")
                    featureRow(icon: "paintbrush.fill", title: "Exclusive Themes", subtitle: "Customize the app's look and feel.")
                }
                .padding(30)
                
                Spacer()
                
                // Purchase Button (Placeholder)
                Button {
                    print("Purchase initiated!")
                    dismiss()
                } label: {
                    Text("Unlock Pro for $9.99")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.skillGradient)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .overlay(alignment: .topTrailing) {
                Button { dismiss() } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.gray.opacity(0.5))
                }
                .padding()
            }
        }
    }
    
    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.largeTitle)
                .frame(width: 50)
                .foregroundStyle(Color.theme.accent)
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                    // Use the primary text color for the title
                    .foregroundStyle(Color.theme.primaryText)
                // --- FIX #2 ---
                // Replaced 'secondaryText' with the standard '.secondary' color
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
