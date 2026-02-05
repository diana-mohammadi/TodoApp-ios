import SwiftUI

struct SettingsView: View {

    var body: some View {
        AppBackground {
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
                            Text("Optimized device")
                            Spacer()
                            Text("iPhone 17 Pro").opacity(0.8)
                        }
                    }
                }

                BrandCard {
                    Text("UI prototype only – no real data")
                        .opacity(0.85)
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Settings")
    }
}

