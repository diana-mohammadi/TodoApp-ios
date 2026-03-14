import SwiftUI

struct TypesView: View {

    @EnvironmentObject var session: AppSession
    @State private var showAddType = false

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        AppBackground {
            ZStack(alignment: .bottomTrailing) {

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Categories")
                                .font(.largeTitle.bold())

                            Text("Your task types")
                                .font(.caption)
                                .opacity(0.85)
                        }
                        .padding(.top, 12)

                        if session.taskTypes.isEmpty {
                            VStack(spacing: 14) {
                                Spacer(minLength: 60)
                                Image(systemName: "square.grid.2x2")
                                    .font(.system(size: 48))
                                    .opacity(0.5)
                                Text("No types yet")
                                    .font(.title3.weight(.semibold))
                                    .opacity(0.7)
                                Text("Tap + to create one")
                                    .font(.subheadline)
                                    .opacity(0.5)
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(session.taskTypes) { type in
                                    TypeCardView(type: type)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                session.deleteType(id: type.id)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }

                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal)
                }

                Button {
                    showAddType = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.95, green: 0.35, blue: 0.70),
                                    Color(red: 0.45, green: 0.35, blue: 0.95)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            .navigationTitle("Task Types")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddType) {
                AddTypesView()
            }
        }
    }
}
