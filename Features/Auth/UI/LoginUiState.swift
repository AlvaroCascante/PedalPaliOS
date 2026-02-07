import Foundation

/// Represents the UI state for the login screen. Views should only read this.
struct LoginUiState {
    var email: String = ""
    var password: String = ""

    var isLoading: Bool = false
    var isEmailVerificationSent: Bool = false

    var isLoggedIn: Bool = false
    var isProfileComplete: Bool = false

    var currentUser: FirebaseUserInfo?
    var errorMessage: String?
}
