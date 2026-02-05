import SwiftUI

struct EditProfileView: View {

    var body: some View {
        AppBackground {
            VStack(spacing: 16) {

                BrandCard {
                    VStack(spacing: 12) {
                        TextField("Full name", text: .constant(""))
                        TextField("Username", text: .constant(""))
                        TextField("Email", text: .constant(""))
                    }
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Edit Profile")
    }
}
