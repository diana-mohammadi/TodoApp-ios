//Arash Shalchian
//101414035
// Replaced the placeholder TextFields with real state variables.
// Pre-fills fields with the current user's data on appear.
// Calls session.updateProfile() to save changes to Core Data.
// Shows a brief success message before dismissing the screen.
import SwiftUI

struct EditProfileView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss

    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var saved = false

    var body: some View {
        AppBackground {
            VStack(spacing: 16) {

                BrandCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Edit Profile")
                            .font(.title3.bold())
                        Text("Update your personal information.")
                            .font(.caption)
                            .opacity(0.8)
                    }
                }

                BrandCard {
                    VStack(alignment: .leading, spacing: 14) {

                        fieldBlock(label: "Full Name") {
                            TextField("Full name", text: $fullName)
                                .textInputAutocapitalization(.words)
                        }

                        fieldBlock(label: "Username") {
                            TextField("Username", text: $username)
                                .textInputAutocapitalization(.never)
                        }

                        fieldBlock(label: "Email") {
                            TextField("Email", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }

                        if saved {
                            Text("Profile updated!")
                                .font(.caption)
                                .foregroundColor(.green.opacity(0.9))
                        }
                    }
                }

                HStack(spacing: 12) {
                    Button("Cancel") { dismiss() }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white.opacity(0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Save") {
                        let cleanName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
                        let cleanUser = username.trimmingCharacters(in: .whitespacesAndNewlines)
                        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !cleanName.isEmpty, !cleanUser.isEmpty, !cleanEmail.isEmpty else { return }
                        session.updateProfile(fullName: cleanName, username: cleanUser, email: cleanEmail)
                        saved = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { dismiss() }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.24))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 16)

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            fullName = session.currentUser.fullName
            username = session.currentUser.username
            email = session.currentUser.email
        }
    }

    @ViewBuilder
    private func fieldBlock<F: View>(label: String, @ViewBuilder field: () -> F) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .opacity(0.8)
            field()
                .padding(12)
                .background(Color.white.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}
