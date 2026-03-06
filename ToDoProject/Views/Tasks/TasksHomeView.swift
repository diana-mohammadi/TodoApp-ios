import SwiftUI

struct TasksHomeView: View {

    @EnvironmentObject var session: AppSession
    @State private var showAddTask = false

    var body: some View {
        AppBackground {
            ZStack(alignment: .bottomTrailing) {

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        // Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Today")
                                .font(.largeTitle.bold())

                            Text("Your tasks overview")
                                .font(.caption)
                                .opacity(0.85)
                        }
                        .padding(.top, 12)

                        // Task list
                        VStack(spacing: 12) {
                            ForEach(session.tasks) { task in
                                TaskCard(task: task)
                            }
                        }

                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal)
                }

                // Floating + button
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.95, green: 0.35, blue: 0.70),
                                    Color(red: 0.45, green: 0.35, blue: 0.95)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddTask) {
                AddTaskView()
            }
        }
    }
}


