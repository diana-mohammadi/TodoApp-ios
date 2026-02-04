import SwiftUI

struct TaskCard: View {
    let task: TaskItem

    var body: some View {
        CardView {
            HStack(alignment: .top) {

                VStack(alignment: .leading, spacing: 6) {
                    Text(task.title)
                        .font(.headline)

                    Text("\(task.type.name) • \(task.notes)")
                        .font(.caption)
                        .opacity(0.75)
                }

                Spacer()

                TaskStatusTag(status: task.status)
            }
        }
    }
}


