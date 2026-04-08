//Radin Madad Nezhad Aligorkeh
//101474661
// New screen that allows the user to edit an existing task.
// Pre-fills all fields with the current task data on appear.
// Calls session.editTask() to update the task in both Core Data and the in-memory list.
// Supports changing the title, notes, due date, category, and status.
import SwiftUI

struct EditTaskView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss

    let task: TaskItem

    @State private var title: String
    @State private var notes: String
    @State private var dueDate: Date
    @State private var selectedTypeIndex: Int
    @State private var selectedStatus: TaskStatus

    private var taskTypes: [TaskType] { session.taskTypes }

    init(task: TaskItem) {
        self.task = task
        _title = State(initialValue: task.title)
        _notes = State(initialValue: task.notes)
        _dueDate = State(initialValue: task.dueDate)
        _selectedStatus = State(initialValue: task.status)
        let idx = MockData.taskTypes.firstIndex(where: { $0.id == task.type.id }) ?? 0
        _selectedTypeIndex = State(initialValue: idx)
    }

    private var selectedTaskType: TaskType {
        guard !taskTypes.isEmpty else { return TaskType(name: "General", icon: "checkmark.circle.fill") }
        guard taskTypes.indices.contains(selectedTypeIndex) else { return taskTypes[0] }
        return taskTypes[selectedTypeIndex]
    }

    var body: some View {
        AppBackground {
            VStack(spacing: 14) {

                BrandCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Edit Task")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Update your task details.")
                            .font(.caption)
                            .opacity(0.8)
                    }
                }

                BrandCard {
                    VStack(alignment: .leading, spacing: 14) {

                        fieldBlock(label: "Title") {
                            TextField("e.g., Finish assignment", text: $title)
                                .textInputAutocapitalization(.sentences)
                        }

                        fieldBlock(label: "Notes") {
                            TextField("Optional notes...", text: $notes, axis: .vertical)
                                .lineLimit(3...6)
                                .textInputAutocapitalization(.sentences)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Due date")
                                .font(.caption)
                                .opacity(0.8)
                            DatePicker("Due date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                                .labelsHidden()
                                .padding(12)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Category")
                                .font(.caption)
                                .opacity(0.8)
                            Picker("Category", selection: $selectedTypeIndex) {
                                ForEach(taskTypes.indices, id: \.self) { i in
                                    HStack(spacing: 8) {
                                        Image(systemName: taskTypes[i].icon)
                                        Text(taskTypes[i].name)
                                    }
                                    .tag(i)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Status")
                                .font(.caption)
                                .opacity(0.8)
                            Picker("Status", selection: $selectedStatus) {
                                ForEach(TaskStatus.allCases) { status in
                                    Text(status.rawValue.capitalized).tag(status)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(12)
                            .background(Color.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }

                HStack(spacing: 12) {
                    Button("Cancel") { dismiss() }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white.opacity(0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Save") {
                        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !cleanTitle.isEmpty else { return }
                        session.editTask(
                            id: task.id,
                            title: cleanTitle,
                            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
                            dueDate: dueDate,
                            type: selectedTaskType,
                            status: selectedStatus
                        )
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.24))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 16)

                Spacer(minLength: 8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let idx = taskTypes.firstIndex(where: { $0.id == task.type.id }) {
                selectedTypeIndex = idx
            }
        }
    }

    @ViewBuilder
    private func fieldBlock<F: View>(label: String, @ViewBuilder field: () -> F) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .opacity(0.8)
            field()
                .padding(12)
                .background(Color.white.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}
