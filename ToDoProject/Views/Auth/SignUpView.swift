//Diana Mohammadi
//101481507

// New screen that lets a new user create an account.
// Collects full name, username, email, and password.
// Calls session.signup() which saves the user to Core Data and seeds their default data.
// Shows an error if the email is already registered or fields are incomplete.
import SwiftUI

struct SignUpView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        AppBackground {
            ScrollView {
                VStack(spacing: 16) {

                    BrandCard {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Create Account")
                                .font(.title3.bold())
                            Text("Join planIt to start organizing.")
                                .font(.caption)
                                .opacity(0.8)
                        }
                    }

                    BrandCard {
                        VStack(alignment: .leading, spacing: 14) {

                            fieldBlock(label: "Full Name") {
                                TextField("e.g., Diana Mohammadi", text: $fullName)
                                    .textInputAutocapitalization(.words)
                            }

                            fieldBlock(label: "Username") {
                                TextField("e.g., diana", text: $username)
                                    .textInputAutocapitalization(.never)
                            }

                            fieldBlock(label: "Email") {
                                TextField("e.g., diana@email.com", text: $email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }

                            fieldBlock(label: "Password") {
                                SecureField("At least 6 characters", text: $password)
                            }

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red.opacity(0.9))
                            }
                        }
                    }

                    Button("Create Account") {
                        let cleanName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
                        let cleanUser = username.trimmingCharacters(in: .whitespacesAndNewlines)
                        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

                        guard !cleanName.isEmpty, !cleanUser.isEmpty, !cleanEmail.isEmpty, password.count >= 6 else {
                            errorMessage = "Please fill all fields. Password must be at least 6 characters."
                            return
                        }

                        let success = session.signup(fullName: cleanName, username: cleanUser, email: cleanEmail, password: password)
                        if !success {
                            errorMessage = "An account with this email already exists."
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.24))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 16)

                    Button("Already have an account? Sign In") {
                        dismiss()
                    }
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))

                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
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
