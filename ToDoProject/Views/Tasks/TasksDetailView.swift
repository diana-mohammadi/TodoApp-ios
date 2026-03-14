import SwiftUI

struct TasksDetailView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss
    let task: TaskItem

    var body: some View {
        AppBackground {
            ScrollView {
                VStack(spacing: 16) {

                    BrandCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(task.title)
                                .font(.title3.bold())

                            if !task.notes.isEmpty {
                                Text(task.notes)
                                    .font(.subheadline)
                                    .opacity(0.85)
                            }
                        }
                    }

                    BrandCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 10) {
                                Image(systemName: task.type.icon)
                                    .font(.system(size: 18, weight: .semibold))
                                Text(task.type.name)
                                    .font(.subheadline)
                            }

                            HStack(spacing: 10) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 18, weight: .semibold))
                                Text(task.dueDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.subheadline)
                            }
                        }
                    }

                    BrandCard {
                        HStack {
                            Text("Status")
                                .font(.subheadline)
                            Spacer()
                            TaskStatusTag(status: task.status)
                        }
                    }

                    Spacer(minLength: 20)

                    Button {
                        session.deleteTask(id: task.id)
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Task")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.red.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.horizontal, 16)
                }
                .padding(16)
            }
        }
        .navigationTitle("Task Details")
    }
}
