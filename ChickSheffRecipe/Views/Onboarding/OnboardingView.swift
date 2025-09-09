import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("WarmRed"), Color("Red"), Color("Yellow").opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                TabView(selection: $selection) {
                    OnboardingPage(
                        imageSystemName: "fork.knife.circle.fill",
                        title: "Welcome to Chicken Chef",
                        subtitle: "Discover and cook delicious chicken recipes",
                        bulletPoints: [
                            "Curated recipes with images",
                            "Add your own recipes",
                            "Favorites and search"
                        ]
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        imageSystemName: "timer.circle.fill",
                        title: "Cook with a built-in Timer",
                        subtitle: "Stay on track with notifications",
                        bulletPoints: [
                            "Start, pause and resume",
                            "Progress and remaining time",
                            "Alerts when done"
                        ]
                    )
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                
                HStack(spacing: 12) {
                    if selection == 0 {
                        Button("Skip") {
                            hasSeenOnboarding = true
                            dismiss()
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(selection == 0 ? "Next" : "Get Started") {
                        if selection == 0 {
                            withAnimation { selection = 1 }
                        } else {
                            hasSeenOnboarding = true
                            dismiss()
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("WarmRed"), Color("Red")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top)
        }
    }
}

private struct OnboardingPage: View {
    let imageSystemName: String
    let title: String
    let subtitle: String
    let bulletPoints: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white.opacity(0.25), Color.white.opacity(0.15)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 140, height: 140)
                
                Image(systemName: imageSystemName)
                    .font(.system(size: 72))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            }
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(subtitle)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(bulletPoints, id: \.self) { point in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Yellow"))
                        Text(point)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView()
}
