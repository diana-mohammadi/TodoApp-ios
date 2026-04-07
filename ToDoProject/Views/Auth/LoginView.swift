//Diana Mohammadi
//101481507

// Replaced the prototype instant-login button with a real login flow.
// Calls session.login() which checks credentials against Core Data.
// Shows an error message if the email or password is incorrect.
// Added navigation to SignUpView for new users.


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: AppSession

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("planIt")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    Text("Sign in to your account")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))

                    VStack(spacing: 12) {
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        SecureField("Password", text: $password)
                            .padding()
                            .background(.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                        }

                        Button {
                            let success = session.login(email: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password)
                            if !success {
                                errorMessage = "Incorrect email or password."
                            }
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.black.opacity(0.85))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                    .padding(.top, 10)

                    NavigationLink(destination: SignUpView()) {
                        Text("Don't have an account? Sign Up")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }

                    Spacer(minLength: 0)
                }
                .padding(20)
                .padding(.top, 40)
            }
        }
    }
}
