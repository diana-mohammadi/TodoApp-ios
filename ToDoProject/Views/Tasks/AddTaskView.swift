import SwiftUI

struct AddTaskView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var dueDate: Date = Date()
    @State private var selectedTypeIndex: Int = 0

    
    private let taskTypes: [TaskType] = [
        TaskType(name: "School", icon: "graduationcap.fill"),
        TaskType(name: "Work", icon: "briefcase.fill"),
        TaskType(name: "Health", icon: "heart.fill"),
        TaskType(name: "Home", icon: "house.fill")
    ]

    
    private var selectedTaskType: TaskType {
        guard taskTypes.indices.contains(selectedTypeIndex) else {
            return taskTypes.first!
        }
        return taskTypes[selectedTypeIndex]
    }

    var body: some View {
        AppBackground {
            VStack(spacing: 14) {

                // Header
                BrandCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("New Task")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("UI only — we’re not saving yet.")
                            .font(.caption)
                            .opacity(0.8)
                    }
                }

                
                BrandCard {
                    VStack(alignment: .leading, spacing: 14) {

                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Title")
                                .font(.caption)
                                .opacity(0.8)

                            TextField("e.g., Finish assignment", text: $title)
                                .textInputAutocapitalization(.sentences)
                                .padding(12)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Notes")
                                .font(.caption)
                                .opacity(0.8)

                            TextField("Optional notes...", text: $notes, axis: .vertical)
                                .lineLimit(3...6)
                                .textInputAutocapitalization(.sentences)
                                .padding(12)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Due date")
                                .font(.caption)
                                .opacity(0.8)

                            DatePicker(
                                "Due date",
                                selection: $dueDate,
                                displayedComponents: [.date, .hourAndMinute]
                            )
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

                        
                        HStack(spacing: 10) {
                            Image(systemName: selectedTaskType.icon)
                                .font(.system(size: 18, weight: .semibold))

                            VStack(alignment: .leading, spacing: 2) {
                                Text(title.isEmpty ? "Task title preview" : title)
                                    .font(.headline)
                                    .lineLimit(1)

                                Text(
                                    selectedTaskType.name + " • " +
                                    dueDate.formatted(date: .abbreviated, time: .shortened)
                                )
                                .font(.caption)
                                .opacity(0.8)
                            }

                            Spacer()
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.10))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }

                // Buttons
                HStack(spacing: 12) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.14))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Create") {
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
        .onAppear {
            
            if !taskTypes.indices.contains(selectedTypeIndex) {
                selectedTypeIndex = 0
            }
        }
        .navigationTitle("Add Task")
        .navigationBarTitleDisplayMode(.inline)
    }
}


