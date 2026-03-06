import Foundation
import Combine

@MainActor
final class AppSession: ObservableObject {

    @Published var isLoggedIn: Bool = false

    // Regular splash screen control
    @Published var hasSeenSplash: Bool = false

    // Current user
    @Published var currentUser: UserProfile = UserProfile(
        fullName: "Diana Mohammadi",
        username: "diana",
        email: "diana@example.com"
    )

    // NEW: real in-memory task storage
    @Published var taskTypes: [TaskType] = MockData.taskTypes
    @Published var tasks: [TaskItem] = MockData.tasks

    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }

    // NEW: add task function
    func addTask(title: String, notes: String, dueDate: Date, type: TaskType) {
        let status: TaskStatus

        if dueDate < Date() {
            status = .overdue
        } else {
            status = .dueSoon
        }

        let newTask = TaskItem(
            title: title,
            notes: notes.isEmpty ? type.name : notes,
            type: type,
            dueDate: dueDate,
            status: status
        )

        tasks.append(newTask)
    }
}