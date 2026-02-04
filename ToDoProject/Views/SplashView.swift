import SwiftUI

struct SplashView: View {
    @EnvironmentObject var session: AppSession
    @State private var animate = false

    var body: some View {
        AppBackground {
            VStack(spacing: 18) {
                Spacer()

                VStack(spacing: 10) {
                    Image(systemName: "checklist")
                        .font(.system(size: 46, weight: .semibold))
                        .scaleEffect(animate ? 1.0 : 0.92)
                        .opacity(animate ? 1 : 0.75)

                    Text("planIt")
                        .font(.system(size: 34, weight: .bold, design: .rounded))

                    Text("Organize your tasks. Plan your time.")
                        .font(.subheadline)
                        .opacity(0.9)
                }
                .padding(.bottom, 10)

                BrandCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Team")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Diana Mohammadi")
                            Text("Arash Shalchian")
                            Text("Radin Madad Nezhad Algorkeh")
                        }
                        .opacity(0.95)
                    }
                }

                Spacer()

                Text("UI prototype • no real login yet")
                    .font(.footnote)
                    .opacity(0.75)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                animate = true
            }
            // Splash duration
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                session.hasSeenSplash = true
            }
        }
    }
}
