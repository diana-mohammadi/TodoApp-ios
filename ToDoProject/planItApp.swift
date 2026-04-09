//Arash Shalchian
//101414035
// Injected the Core Data managed object context into the SwiftUI environment.
// PersistenceController is initialized here at the app level and shared down the view hierarchy.
import SwiftUI

@main
struct planItApp: App {
    @StateObject private var session = AppSession()
    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(session)
                .environment(\.managedObjectContext, persistence.context)
        }
    }
    init() {
        Thread.sleep(forTimeInterval: 1.0)
    }
}
