import SwiftUI

struct AddTypesView: View {

    var body: some View {
        AppBackground {
            VStack(spacing: 16) {

                BrandCard {
                    TextField("Type name", text: .constant(""))
                }

                BrandCard {
                    Text("Icon picker (UI only)")
                        .opacity(0.8)
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Add Type")
    }
}

