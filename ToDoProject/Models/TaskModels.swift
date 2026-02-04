import Foundation

enum TaskStatus: String, CaseIterable, Identifiable {
    case overdue
    case dueSoon
    case completed

    var id: String { rawValue }
}

struct TaskType: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
}

struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    let notes: String
    let type: TaskType
    let dueDate: Date
    let status: TaskStatus
}
