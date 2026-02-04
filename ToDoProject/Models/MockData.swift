import Foundation

enum MockData {

    static let taskTypes: [TaskType] = [
        TaskType(name: "School", icon: "graduationcap.fill"),
        TaskType(name: "Work", icon: "briefcase.fill"),
        TaskType(name: "Health", icon: "heart.fill"),
        TaskType(name: "Home", icon: "house.fill")
    ]

    static let tasks: [TaskItem] = [
        TaskItem(
            title: "Finish GUI milestone",
            notes: "School • Due today",
            type: taskTypes[0],
            dueDate: Date(),
            status: .overdue
        ),
        TaskItem(
            title: "Record demo video",
            notes: "Work • Due tomorrow",
            type: taskTypes[1],
            dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            status: .dueSoon
        ),
        TaskItem(
            title: "Gym session",
            notes: "Health",
            type: taskTypes[2],
            dueDate: Date(),
            status: .completed
        )
    ]
}

