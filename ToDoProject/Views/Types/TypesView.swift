import SwiftUI

struct TypesView: View {

    var body: some View {
        AppBackground {
            VStack(spacing: 14) {

                BrandCard {
                    Text("Work")
                }

                BrandCard {
                    Text("School")
                }

                BrandCard {
                    Text("Health")
                }

                BrandCard {
                    Text("Home")
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Task Types")
    }
}

