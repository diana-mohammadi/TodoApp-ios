import SwiftUI

struct RootTabView: View {

    var body: some View {
        TabView {
            NavigationStack {
                TasksHomeView()
            }
            .tabItem { Label("Tasks", systemImage: "checklist") }

            NavigationStack {
                TypesView()
            }
            .tabItem { Label("Types", systemImage: "square.grid.2x2") }

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}


