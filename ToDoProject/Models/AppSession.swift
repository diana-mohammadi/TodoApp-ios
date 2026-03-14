import Foundation
import Combine

@MainActor
final class AppSession: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var hasSeenSplash: Bool = false

    @Published var currentUser: UserProfile = UserProfile(
        fullName: "Diana Mohammadi",
        username: "diana",
        email: "diana@example.com"
    )

    @Published var taskTypes: [TaskType] = MockData.taskTypes
    @Published var tasks: [TaskItem] = MockData.tasks

    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }

    func addTask(title: String, notes: String, dueDate: Date, type: TaskType) {
        let status: TaskStatus = dueDate < Date() ? .overdue : .dueSoon
        let newTask = TaskItem(
            title: title,
            notes: notes.isEmpty ? type.name : notes,
            type: type,
            dueDate: dueDate,
            status: status
        )
        tasks.append(newTask)
    }

    func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
    }

    func addType(name: String, icon: String) {
        let newType = TaskType(name: name, icon: icon)
        taskTypes.append(newType)
    }

    func deleteType(id: UUID) {
        taskTypes.removeAll { $0.id == id }
    }

    func resetData() {
        tasks = MockData.tasks
        taskTypes = MockData.taskTypes
    }
}