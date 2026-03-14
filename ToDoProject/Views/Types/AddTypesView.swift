import SwiftUI

struct AddTypesView: View {

    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var selectedIcon: String = "folder.fill"

    private let icons: [String] = [
        "folder.fill",
        "graduationcap.fill",
        "briefcase.fill",
        "heart.fill",
        "house.fill",
        "cart.fill",
        "airplane",
        "car.fill",
        "leaf.fill",
        "book.fill",
        "music.note",
        "gamecontroller.fill",
        "paintbrush.fill",
        "wrench.fill",
        "dollarsign.circle.fill",
        "star.fill",
        "flag.fill",
        "bolt.fill",
        "person.2.fill",
        "bell.fill"
    ]

    private let iconColumns = [
        GridItem(.adaptive(minimum: 52), spacing: 10)
    ]

    var body: some View {
        AppBackground {
            VStack(spacing: 14) {

                BrandCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("New Type")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("Create a category for your tasks.")
                            .font(.caption)
                            .opacity(0.8)
                    }
                }

                BrandCard {
                    VStack(alignment: .leading, spacing: 14) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Name")
                                .font(.caption)
                                .opacity(0.8)

                            TextField("e.g., Fitness", text: $name)
                                .textInputAutocapitalization(.words)
                                .padding(12)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Icon")
                                .font(.caption)
                                .opacity(0.8)

                            LazyVGrid(columns: iconColumns, spacing: 10) {
                                ForEach(icons, id: \.self) { icon in
                                    Button {
                                        selectedIcon = icon
                                    } label: {
                                        Image(systemName: icon)
                                            .font(.system(size: 20))
                                            .frame(width: 44, height: 44)
                                            .background(
                                                selectedIcon == icon
                                                    ? Color.white.opacity(0.3)
                                                    : Color.white.opacity(0.1)
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(
                                                        selectedIcon == icon
                                                            ? Color.white.opacity(0.6)
                                                            : Color.clear,
                                                        lineWidth: 2
                                                    )
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        HStack(spacing: 10) {
                            Image(systemName: selectedIcon)
                                .font(.system(size: 18, weight: .semibold))
                            Text(name.isEmpty ? "Type preview" : name)
                                .font(.headline)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.10))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }

                HStack(spacing: 12) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.14))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Create") {
                        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !cleanName.isEmpty else { return }
                        session.addType(name: cleanName, icon: selectedIcon)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.24))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 16)

                Spacer(minLength: 8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .navigationTitle("Add Type")
        .navigationBarTitleDisplayMode(.inline)
    }
}
