//
//  FirebaseAuthDataSourceImpl.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//
import FirebaseAuth
import GoogleSignIn

final class FirebaseAuthDataSourceImpl: FirebaseAuthDataSource {

    private var auth: Auth {
        Auth.auth()
    }

    func getCurrentUserInfo() async throws -> FirebaseUserInfo? {
        guard let user = auth.currentUser else {
            return nil
        }

        try await user.reloadAsync()
        return FirebaseUserMapper.toDomain(user)
    }

    func reloadUser() async throws {
        guard let user = auth.currentUser else {
            throw AuthError.noCurrentUser
        }
        try await user.reloadAsync()
    }

    func getIdToken(forceRefresh: Bool) async throws -> String {
        guard let user = auth.currentUser else {
            throw AuthError.noCurrentUser
        }

        let result = try await user.getIDTokenResultAsync(forceRefresh: forceRefresh)
        return result.token
    }


    func isEmailVerified() async throws -> Bool {
        guard let user = auth.currentUser else {
            return false
        }

        try await user.reloadAsync()
        return user.isEmailVerified
    }

    func sendEmailVerification() async throws {
        guard let user = auth.currentUser else {
            throw AuthError.noCurrentUser
        }

        try await user.sendEmailVerificationAsync()
    }

    func signInWithEmail(email: String, password: String) async throws -> FirebaseUserInfo {
        let result = try await auth.signIn(withEmail: email, password: password)
        return FirebaseUserMapper.toDomain(result.user)
    }

    func signUpWithEmail(email: String, password: String) async throws -> FirebaseUserInfo {
        let result = try await auth.createUser(withEmail: email, password: password)
        return FirebaseUserMapper.toDomain(result.user)
    }

    // MARK: - Google

    func signInWithGoogle(googleIdToken: String) async throws -> FirebaseUserInfo {
        let credential = GoogleAuthProvider.credential(
            withIDToken: googleIdToken,
            accessToken: ""
        )

        let result = try await auth.signIn(with: credential)
        return FirebaseUserMapper.toDomain(result.user)
    }
}
