import SwiftUI

struct TypeCardView: View {
    let type: TaskType

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: type.icon)
                    .font(.title2)
                    .frame(width: 44, height: 44)
                    .background(Color.secondary.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                Text(type.name)
                    .font(.headline)

                Text("Prototype type")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading)
        }
    }
}

