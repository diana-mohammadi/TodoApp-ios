import SwiftUI

struct TaskRowView: View {

    let task: TaskItem

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: task.type.icon)
                .foregroundColor(.accentColor)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)

                Text(task.notes)
                    .font(.caption)
                    .opacity(0.7)
            }

            Spacer()

            TaskStatusTag(status: task.status)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TaskRowView(task: MockData.tasks[0])
}

