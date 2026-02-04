import SwiftUI

struct TaskStatusTag: View {
    let status: TaskStatus

    var body: some View {
        Text(label)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundColor(color)
            .background(color.opacity(0.15))
            .clipShape(Capsule())
    }

    private var label: String {
        switch status {
        case .overdue:
            return "Overdue"
        case .dueSoon:
            return "Due Soon"
        case .completed:
            return "Completed"
        }
    }

    private var color: Color {
        switch status {
        case .overdue:
            return .red
        case .dueSoon:
            return .orange
        case .completed:
            return .green
        }
    }
}

