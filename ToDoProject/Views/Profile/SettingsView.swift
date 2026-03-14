import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var session: AppSession
    @State private var showResetAlert = false

    var body: some View {
        AppBackground {
            ScrollView {
                VStack(spacing: 16) {

                    BrandCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("App")
                                .font(.headline)

                            HStack {
                                Text("Name")
                                Spacer()
                                Text("planIt").opacity(0.8)
                            }

                            HStack {
                                Text("Version")
                                Spacer()
                                Text("1.0.0").opacity(0.8)
                            }

                            HStack {
                                Text("Optimized device")
                                Spacer()
                                Text("iPhone 17 Pro").opacity(0.8)
                            }
                        }
                    }

                    BrandCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About")
                                .font(.headline)

                            Text("planIt helps you organize tasks and plan your time. Built as a SwiftUI prototype.")
                                .font(.subheadline)
                                .opacity(0.85)

                            Divider().opacity(0.3)

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Team")
                                    .font(.subheadline.weight(.semibold))

                                Text("Diana Mohammadi")
                                    .font(.subheadline)
                                    .opacity(0.85)
                                Text("Arash Shalchian")
                                    .font(.subheadline)
                                    .opacity(0.85)
                                Text("Radin Madad Nezhad Algorkeh")
                                    .font(.subheadline)
                                    .opacity(0.85)
                            }
                        }
                    }

                    BrandCard {
                        Button {
                            showResetAlert = true
                        } label: {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("Reset All Data")
                            }
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .alert("Reset All Data?", isPresented: $showResetAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Reset", role: .destructive) {
                            session.resetData()
                        }
                    } message: {
                        Text("This will replace all tasks and types with the default sample data.")
                    }

                    Spacer()
                }
                .padding(16)
            }
        }
        .navigationTitle("Settings")
    }
}
