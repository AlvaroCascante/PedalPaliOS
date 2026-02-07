//
//  AuthRepositoryImpl.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

final class AuthRepositoryImpl: AuthRepository {

    private let remote: AuthRemoteDataSource
    private let firebase: FirebaseAuthDataSource

    init(
        remote: AuthRemoteDataSource,
        firebase: FirebaseAuthDataSource
    ) {
        self.remote = remote
        self.firebase = firebase
    }

    func createBackendUser(
        request: BackendCreateUserRequest,
        firebaseIdToken: String
    ) async throws -> AuthToken {
        try await remote.createUser(
            request: request,
            firebaseIdToken: firebaseIdToken
        )
    }

    func getCurrentUserInfo() async throws -> FirebaseUserInfo? {
        try await firebase.getCurrentUserInfo()
    }

    func getFirebaseIdToken(forceRefresh: Bool) async throws -> String {
        try await firebase.getIdToken(forceRefresh: forceRefresh)
    }

    func isEmailVerified() async throws -> Bool {
        try await firebase.isEmailVerified()
    }

    func reloadUser() async throws {
        try await firebase.reloadUser()
    }

    func sendEmailVerification() async throws {
        try await firebase.sendEmailVerification()
    }

    func signInWithEmail(
        email: String,
        password: String
    ) async throws -> FirebaseUserInfo {
        try await firebase.signInWithEmail(
            email: email,
            password: password
        )
    }

    func signInWithGoogle(
        googleIdToken: String
    ) async throws -> FirebaseUserInfo {
        try await firebase.signInWithGoogle(
            googleIdToken: googleIdToken
        )
    }

    func signUpWithEmail(
        email: String,
        password: String
    ) async throws -> FirebaseUserInfo {
        try await firebase.signUpWithEmail(
            email: email,
            password: password
        )
    }
}
