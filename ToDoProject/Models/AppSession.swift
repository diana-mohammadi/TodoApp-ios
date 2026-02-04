import Foundation
import Combine

@MainActor
final class AppSession: ObservableObject {

    @Published var isLoggedIn: Bool = false

    // Regular splash screen control
    @Published var hasSeenSplash: Bool = false

    // Optional profile model (keep whatever you already have)
    @Published var currentUser: UserProfile = UserProfile(
        fullName: "Diana Mohammadi",
        username: "diana",
        email: "diana@example.com"
    )

    func login() { isLoggedIn = true }
    func logout() { isLoggedIn = false }
}
