import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: AppSession

    @State private var email = ""
    @State private var password = ""

    var body: some View {
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

                Text("Login (Prototype)")
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

                    Button {
                        // Prototype: no real auth yet
                        session.isLoggedIn = true
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

                Button {
                    // Prototype
                } label: {
                    Text("Create account (prototype)")
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

