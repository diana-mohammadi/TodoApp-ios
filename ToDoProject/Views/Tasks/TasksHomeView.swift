import SwiftUI

struct TasksHomeView: View {

    @EnvironmentObject var session: AppSession
    @State private var showAddTask = false

    var body: some View {
        AppBackground {
            ZStack(alignment: .bottomTrailing) {

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Today")
                                .font(.largeTitle.bold())

                            Text("Your tasks overview")
                                .font(.caption)
                                .opacity(0.85)
                        }
                        .padding(.top, 12)

                        if session.tasks.isEmpty {
                            VStack(spacing: 14) {
                                Spacer(minLength: 60)
                                Image(systemName: "tray")
                                    .font(.system(size: 48))
                                    .opacity(0.5)
                                Text("No tasks yet")
                                    .font(.title3.weight(.semibold))
                                    .opacity(0.7)
                                Text("Tap + to add one")
                                    .font(.subheadline)
                                    .opacity(0.5)
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(session.tasks) { task in
                                    NavigationLink(destination: TasksDetailView(task: task)) {
                                        TaskCard(task: task)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            session.deleteTask(id: task.id)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }

                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal)
                }

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
