//Arash Shalchian
//101414035

// Made UserProfile Codable so it can be stored and retrieved from Core Data.
// Added password field to support real authentication.
import Foundation

struct UserProfile: Codable {
    var fullName: String
    var username: String
    var email: String
    var password: String
}


