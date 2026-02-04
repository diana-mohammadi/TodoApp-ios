import SwiftUI

@main
struct planItApp: App {
    @StateObject private var session = AppSession()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(session)
        }
    }
    init() {
        Thread.sleep(forTimeInterval: 1.0)
    }
}

