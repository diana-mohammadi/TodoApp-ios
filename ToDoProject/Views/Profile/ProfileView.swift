import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var session: AppSession

    private var totalTasks: Int { session.tasks.count }
    private var completedTasks: Int { session.tasks.filter { $0.status == .completed }.count }
    private var overdueTasks: Int { session.tasks.filter { $0.status == .overdue }.count }

    var body: some View {
        AppBackground {
            ScrollView {
                VStack(spacing: 16) {

                    BrandCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(session.currentUser.fullName)
                                .font(.headline)
                            Text("@\(session.currentUser.username)")
                                .opacity(0.8)
                            Text(session.currentUser.email)
                                .opacity(0.8)
                        }
                    }

                    BrandCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Task Stats")
                                .font(.headline)

                            HStack(spacing: 0) {
                                statItem(value: totalTasks, label: "Total", color: .blue)
                                Spacer()
                                statItem(value: completedTasks, label: "Done", color: .green)
                                Spacer()
                                statItem(value: overdueTasks, label: "Overdue", color: .red)
                            }
                        }
                    }

                    BrandCard {
                        Text("Edit profile")
                    }

                    Spacer()
                }
                .padding(16)
            }
        }
        .navigationTitle("Profile")
    }

    private func statItem(value: Int, label: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Text("\(value)")
                .font(.title.bold())
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .opacity(0.8)
        }
        .frame(maxWidth: .infinity)
    }
}
