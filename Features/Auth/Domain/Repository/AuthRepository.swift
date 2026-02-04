import Foundation

public protocol AuthRepository {
    func createBackendUser(request: BackendCreateUserRequest, firebaseIdToken: String) async throws -> AuthToken
    func getCurrentUserInfo() async throws -> FirebaseUserInfo?
    func getFirebaseIdToken(forceRefresh: Bool) async throws -> String
    func isEmailVerified() async -> Bool
    func reloadUser() async throws
    func sendEmailVerification() async throws
    func signInWithEmail(email: String, password: String) async throws -> FirebaseUserInfo
    func signInWithGoogle(googleIdToken: String) async throws -> FirebaseUserInfo
    func signUpWithEmail(email: String, password: String) async throws -> FirebaseUserInfo
}
