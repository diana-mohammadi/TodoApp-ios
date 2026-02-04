import SwiftUI

struct TasksDetailView: View {

    var body: some View {
        AppBackground {
            VStack(spacing: 16) {

                BrandCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Finish GUI milestone")
                            .font(.headline)

                        Text("UI only, navigation + layout")
                            .opacity(0.85)
                    }
                }

                BrandCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Status")
                        Text("In Progress")
                            .opacity(0.8)
                    }
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Task Details")
    }
}

