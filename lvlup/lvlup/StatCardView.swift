import SwiftUI

struct StatCardView: View {
    let tracker: StatTracker

    var body: some View {
        VStack(alignment: .leading) {
            // Header with Icon and Progress Ring
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 8)
                
                Circle()
                    .trim(from: 0.0, to: tracker.progress)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                Image(systemName: tracker.iconName)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .frame(width: 50, height: 50)
            
            Spacer()
            
            // Name of the stat
            Text(tracker.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
            
            // Current Value
            Text(String(format: "%.1f", tracker.totalValue))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding()
        .frame(height: 160) // Maintain a consistent height
        .background(tracker.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
