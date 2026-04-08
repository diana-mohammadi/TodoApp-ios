//Radin Madad Nezhad Aligorkeh
//101474661
// Added an Edit Task button that opens EditTaskView as a sheet.
// Added a delete confirmation alert before removing a task.
import SwiftUI

struct TasksDetailView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss
    let task: TaskItem

    @State private var showEditTask = false
    @State private var showDeleteAlert = false

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
                        showEditTask = true
                    } label: {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit Task")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white.opacity(0.22))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.horizontal, 16)

                    Button {
                        showDeleteAlert = true
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
                    .alert("Delete Task?", isPresented: $showDeleteAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Delete", role: .destructive) {
                            session.deleteTask(id: task.id)
                            dismiss()
                        }
                    } message: {
                        Text("This will permanently remove \"\(task.title)\".")
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle("Task Details")
        .sheet(isPresented: $showEditTask) {
            NavigationStack {
                EditTaskView(task: task)
            }
        }
    }
}
