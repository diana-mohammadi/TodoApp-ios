//Diana Mohammadi
//101481507
// Replaced in-memory mock data with full Core Data persistence.
// Added real signup and login functions that store and verify users in Core Data.
// Added logout that clears in-memory data so users don't see each other's tasks.
// Added updateProfile to let users edit and save their personal information.
// Added editTask function to support updating existing tasks.
// All tasks and types are now tagged with ownerEmail so each user only sees their own data.
// On first signup, default mock tasks and types are seeded for that user specifically.
// On login, only that user's tasks and types are loaded from Core Data.
// resetData now only resets the current user's data, not all users.
import Foundation
import Combine
import CoreData

@MainActor
final class AppSession: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var hasSeenSplash: Bool = false
    @Published var currentUser: UserProfile = UserProfile(fullName: "", username: "", email: "", password: "")
    @Published var taskTypes: [TaskType] = []
    @Published var tasks: [TaskItem] = []

    private let context = PersistenceController.shared.context

    init() {}

    // Auth

    func signup(fullName: String, username: String, email: String, password: String) -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        request.predicate = NSPredicate(format: "email == %@", email)
        let existing = (try? context.fetch(request)) ?? []
        if !existing.isEmpty { return false }

        let user = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: context)
        user.setValue(fullName, forKey: "fullName")
        user.setValue(username, forKey: "username")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        PersistenceController.shared.save()

        currentUser = UserProfile(fullName: fullName, username: username, email: email, password: password)
        isLoggedIn = true

        // Seed defaults for this brand new user
        seedTypes(MockData.taskTypes)
        seedTasks(MockData.tasks)

        return true
    }

    func login(email: String, password: String) -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        let results = (try? context.fetch(request)) ?? []
        if let match = results.first {
            currentUser = UserProfile(
                fullName: match.value(forKey: "fullName") as? String ?? "",
                username: match.value(forKey: "username") as? String ?? "",
                email: match.value(forKey: "email") as? String ?? "",
                password: match.value(forKey: "password") as? String ?? ""
            )
            isLoggedIn = true
            // Load only this user's data
            loadTypes()
            loadTasks()
            return true
        }
        return false
    }

    func logout() {
        isLoggedIn = false
        // Clear in-memory data so next user starts fresh in memory
        tasks = []
        taskTypes = []
    }

    func updateProfile(fullName: String, username: String, email: String) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        request.predicate = NSPredicate(format: "email == %@", currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        if let user = results.first {
            user.setValue(fullName, forKey: "fullName")
            user.setValue(username, forKey: "username")
            user.setValue(email, forKey: "email")
            PersistenceController.shared.save()
            currentUser.fullName = fullName
            currentUser.username = username
            currentUser.email = email
        }
    }

    //Tasks

    func addTask(title: String, notes: String, dueDate: Date, type: TaskType) {
        let status: TaskStatus = dueDate < Date() ? .overdue : .dueSoon
        let newID = UUID()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "TaskItemEntity", into: context)
        entity.setValue(newID, forKey: "id")
        entity.setValue(title, forKey: "title")
        entity.setValue(notes.isEmpty ? type.name : notes, forKey: "notes")
        entity.setValue(dueDate, forKey: "dueDate")
        entity.setValue(status.rawValue, forKey: "status")
        entity.setValue(type.name, forKey: "typeName")
        entity.setValue(type.icon, forKey: "typeIcon")
        entity.setValue(type.id, forKey: "typeID")
        entity.setValue(currentUser.email, forKey: "ownerEmail")
        PersistenceController.shared.save()
        tasks.append(TaskItem(id: newID, title: title, notes: notes.isEmpty ? type.name : notes, type: type, dueDate: dueDate, status: status))
    }

    func editTask(id: UUID, title: String, notes: String, dueDate: Date, type: TaskType, status: TaskStatus) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TaskItemEntity")
        request.predicate = NSPredicate(format: "id == %@ AND ownerEmail == %@", id as CVarArg, currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        if let task = results.first {
            task.setValue(title, forKey: "title")
            task.setValue(notes, forKey: "notes")
            task.setValue(dueDate, forKey: "dueDate")
            task.setValue(status.rawValue, forKey: "status")
            task.setValue(type.name, forKey: "typeName")
            task.setValue(type.icon, forKey: "typeIcon")
            task.setValue(type.id, forKey: "typeID")
            PersistenceController.shared.save()
        }
        if let idx = tasks.firstIndex(where: { $0.id == id }) {
            tasks[idx].title = title
            tasks[idx].notes = notes
            tasks[idx].dueDate = dueDate
            tasks[idx].type = type
            tasks[idx].status = status
        }
    }

    func deleteTask(id: UUID) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TaskItemEntity")
        request.predicate = NSPredicate(format: "id == %@ AND ownerEmail == %@", id as CVarArg, currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        results.forEach { context.delete($0) }
        PersistenceController.shared.save()
        tasks.removeAll { $0.id == id }
    }

    // Types

    func addType(name: String, icon: String) {
        let newType = TaskType(name: name, icon: icon)
        let entity = NSEntityDescription.insertNewObject(forEntityName: "TaskTypeEntity", into: context)
        entity.setValue(newType.id, forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(icon, forKey: "icon")
        entity.setValue(currentUser.email, forKey: "ownerEmail")
        PersistenceController.shared.save()
        taskTypes.append(newType)
    }

    func deleteType(id: UUID) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TaskTypeEntity")
        request.predicate = NSPredicate(format: "id == %@ AND ownerEmail == %@", id as CVarArg, currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        results.forEach { context.delete($0) }
        PersistenceController.shared.save()
        taskTypes.removeAll { $0.id == id }
    }

    func resetData() {
        let taskReq = NSFetchRequest<NSManagedObject>(entityName: "TaskItemEntity")
        taskReq.predicate = NSPredicate(format: "ownerEmail == %@", currentUser.email)
        let typeReq = NSFetchRequest<NSManagedObject>(entityName: "TaskTypeEntity")
        typeReq.predicate = NSPredicate(format: "ownerEmail == %@", currentUser.email)

        ((try? context.fetch(taskReq)) ?? []).forEach { context.delete($0) }
        ((try? context.fetch(typeReq)) ?? []).forEach { context.delete($0) }
        PersistenceController.shared.save()

        tasks = []
        taskTypes = []
        seedTypes(MockData.taskTypes)
        seedTasks(MockData.tasks)
    }

    // Load from Core Data (filtered by current user)

    private func loadTasks() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TaskItemEntity")
        request.predicate = NSPredicate(format: "ownerEmail == %@", currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        tasks = results.compactMap { obj in
            guard
                let id = obj.value(forKey: "id") as? UUID,
                let title = obj.value(forKey: "title") as? String,
                let notes = obj.value(forKey: "notes") as? String,
                let dueDate = obj.value(forKey: "dueDate") as? Date,
                let statusRaw = obj.value(forKey: "status") as? String,
                let status = TaskStatus(rawValue: statusRaw),
                let typeName = obj.value(forKey: "typeName") as? String,
                let typeIcon = obj.value(forKey: "typeIcon") as? String,
                let typeID = obj.value(forKey: "typeID") as? UUID
            else { return nil }
            return TaskItem(id: id, title: title, notes: notes, type: TaskType(id: typeID, name: typeName, icon: typeIcon), dueDate: dueDate, status: status)
        }
    }

    private func loadTypes() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "TaskTypeEntity")
        request.predicate = NSPredicate(format: "ownerEmail == %@", currentUser.email)
        let results = (try? context.fetch(request)) ?? []
        taskTypes = results.compactMap { obj in
            guard
                let id = obj.value(forKey: "id") as? UUID,
                let name = obj.value(forKey: "name") as? String,
                let icon = obj.value(forKey: "icon") as? String
            else { return nil }
            return TaskType(id: id, name: name, icon: icon)
        }
    }

    private func seedTypes(_ types: [TaskType]) {
        for type in types {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "TaskTypeEntity", into: context)
            entity.setValue(type.id, forKey: "id")
            entity.setValue(type.name, forKey: "name")
            entity.setValue(type.icon, forKey: "icon")
            entity.setValue(currentUser.email, forKey: "ownerEmail")
            taskTypes.append(type)
        }
        PersistenceController.shared.save()
    }

    private func seedTasks(_ items: [TaskItem]) {
        for item in items {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "TaskItemEntity", into: context)
            entity.setValue(item.id, forKey: "id")
            entity.setValue(item.title, forKey: "title")
            entity.setValue(item.notes, forKey: "notes")
            entity.setValue(item.dueDate, forKey: "dueDate")
            entity.setValue(item.status.rawValue, forKey: "status")
            entity.setValue(item.type.name, forKey: "typeName")
            entity.setValue(item.type.icon, forKey: "typeIcon")
            entity.setValue(item.type.id, forKey: "typeID")
            entity.setValue(currentUser.email, forKey: "ownerEmail")
            tasks.append(item)
        }
        PersistenceController.shared.save()
    }
}
