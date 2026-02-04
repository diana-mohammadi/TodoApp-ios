import SwiftUI

struct AppRootView: View {
    @EnvironmentObject var session: AppSession

    var body: some View {
        Group {
            if !session.hasSeenSplash {
                SplashView()
            } else if session.isLoggedIn {
                RootTabView()
            } else {
                LoginView()
            }
        }
    }
}



