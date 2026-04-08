//Radin Madad Nezhad Aligorkeh
//101474661
// Made TaskType and TaskItem Codable to support Core Data persistence.
// Added custom initializers with default UUID so IDs are preserved when saving and loading.
// Made TaskStatus Codable as well to support encoding the status field.
import Foundation

enum TaskStatus: String, CaseIterable, Identifiable, Codable {
    case overdue
    case dueSoon
    case completed

    var id: String { rawValue }
}

struct TaskType: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let icon: String

    init(id: UUID = UUID(), name: String, icon: String) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}

struct TaskItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var notes: String
    var type: TaskType
    var dueDate: Date
    var status: TaskStatus

    init(id: UUID = UUID(), title: String, notes: String, type: TaskType, dueDate: Date, status: TaskStatus) {
        self.id = id
        self.title = title
        self.notes = notes
        self.type = type
        self.dueDate = dueDate
        self.status = status
    }
}
