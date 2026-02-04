import SwiftUI

struct ProfileView: View {

    var body: some View {
        AppBackground {
            VStack(spacing: 16) {

                BrandCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Diana Mohammadi")
                            .font(.headline)
                        Text("@diana")
                            .opacity(0.8)
                        Text("diana@example.com")
                            .opacity(0.8)
                    }
                }

                BrandCard {
                    Text("Edit profile")
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Profile")
    }
}
